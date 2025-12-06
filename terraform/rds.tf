resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "Allow PostgreSQL access from App SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from App SG"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-db-sg"
    Environment = var.environment
  }
}

resource "aws_db_instance" "default" {
  identifier                = "${var.project_name}-db"
  allocated_storage         = var.db_allocated_storage
  storage_type              = "gp3"
  engine                    = "postgres"
  engine_version            = "16.1"
  instance_class            = var.db_instance_class
  db_name                   = "dspace"
  username                  = "dspace"
  password                  = var.db_password
  parameter_group_name      = "default.postgres16"
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-db-final-snapshot"
  publicly_accessible       = false

  # Backup configuration
  backup_retention_period = var.db_backup_retention_period
  backup_window           = var.db_backup_window
  maintenance_window      = var.db_maintenance_window

  # Enable automated backups
  enabled_cloudwatch_logs_exports = ["postgresql"]

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name        = "${var.project_name}-db"
    Environment = var.environment
  }
}

variable "db_password" {
  description = "Database password (required - should be passed via env var or secrets manager)"
  type        = string
  sensitive   = true
  # No default - must be provided
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS instance in GB"
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting RDS instance. Should be false for production."
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Preferred backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "Preferred maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

environment                = "dev"
instance_type              = "t3.medium"
db_instance_class          = "db.t3.micro"
skip_final_snapshot        = true
db_backup_retention_period = 3
# ssh_allowed_cidr_blocks = ["0.0.0.0/0"]  # WARNING: Restrict in production
# db_password = "your-secure-password-here"  # Must be provided

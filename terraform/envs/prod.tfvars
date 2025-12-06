environment                = "prod"
instance_type              = "t3.large"
db_instance_class          = "db.t3.medium"
skip_final_snapshot        = false
db_backup_retention_period = 30
# ssh_allowed_cidr_blocks = ["YOUR.IP.ADDRESS.HERE/32"]  # REQUIRED: Replace with your admin IP
# db_password = "your-secure-password-here"  # REQUIRED: Use AWS Secrets Manager or secure variable

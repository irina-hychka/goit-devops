variable "identifier" {
  type        = string
  description = "Unique identifier for the RDS instance or Aurora cluster"
}

variable "use_aurora" {
  type        = bool
  default     = false
  description = "If true, creates an Aurora cluster; if false, creates a standard RDS instance"
}

variable "engine" {
  type        = string
  default     = "postgres"
  description = "Database engine type: postgres, mysql, aurora-postgresql, or aurora-mysql"

  validation {
    condition = contains(
      ["postgres", "mysql", "aurora-postgresql", "aurora-mysql"],
      var.engine
    )
    error_message = "Invalid engine type. Allowed values: postgres, mysql, aurora-postgresql, aurora-mysql."
  }
}

variable "engine_version" {
  type        = string
  default     = "15.4"
  description = "Database engine version"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Instance class for the database"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Allocated storage in GB for a standard RDS instance only"

  validation {
    condition     = var.allocated_storage >= 20
    error_message = "Allocated storage must be at least 20 GB."
  }
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "Storage type for a standard RDS instance: gp2, gp3, or io1"

  validation {
    condition     = contains(["gp2", "gp3", "io1"], var.storage_type)
    error_message = "Invalid storage type. Allowed values: gp2, gp3, io1."
  }
}

variable "db_name" {
  type        = string
  description = "Name of the initial database to create"
}

variable "username" {
  type        = string
  description = "Master username for the database"
}

variable "password" {
  type        = string
  sensitive   = true
  description = "Master password for the database"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Enables Multi-AZ deployment for a standard RDS instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the DB subnet group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the database security group will be created"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "List of CIDR blocks allowed to access the database"
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "Number of days to retain automated backups"

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention period must be between 0 and 35 days."
  }
}

variable "port" {
  type        = number
  default     = 5432
  description = "Database port"
}

variable "max_connections" {
  type        = string
  default     = "100"
  description = "Value for the max_connections parameter"
}

variable "log_statement" {
  type        = string
  default     = "none"
  description = "Value for the log_statement parameter"
}

variable "work_mem" {
  type        = string
  default     = "4096"
  description = "Value for the work_mem parameter in KB"
}
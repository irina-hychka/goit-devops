# Aurora cluster (use_aurora = true)
resource "aws_rds_cluster" "this" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier = var.identifier
  engine             = var.engine
  engine_version     = var.engine_version
  database_name      = var.db_name
  master_username    = var.username
  master_password    = var.password
  port               = var.port

  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this[0].name

  storage_encrypted       = true
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = var.backup_retention_period
  apply_immediately       = true

  tags = {
    Name        = var.identifier
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Aurora cluster writer instance
resource "aws_rds_cluster_instance" "writer" {
  count = var.use_aurora ? 1 : 0

  identifier         = "${var.identifier}-writer"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.this[0].engine
  engine_version     = aws_rds_cluster.this[0].engine_version

  publicly_accessible = false
  apply_immediately   = true

  tags = {
    Name        = "${var.identifier}-writer"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
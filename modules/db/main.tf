resource "aws_db_subnet_group" "default" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = var.sg_ids
  multi_az               = var.multi_az
  skip_final_snapshot    = var.skip_final_snapshot
  publicly_accessible    = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  deletion_protection    = var.deletion_protection
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

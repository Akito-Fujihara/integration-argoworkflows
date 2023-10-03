resource "aws_db_subnet_group" "rds" {
  name        = "${var.name}-rds"
  description = "rds subnet group for ${var.name}"
  subnet_ids  = module.vpc.private_subnets
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  identifier             = "${var.name}-db"
  username               = var.mysql_username
  password               = var.mysql_password
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.name
}

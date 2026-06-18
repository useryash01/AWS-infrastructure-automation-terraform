resource "aws_db_subnet_group" "main" {

  name = "main-db-subnet-group"

  subnet_ids = [
  var.private_subnet_1_id,
  var.private_subnet_2_id
 ]
}

resource "aws_security_group" "rds_sg" {

  name   = "rds-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
  var.ecs_sg_id
   ]
  }
}

resource "aws_db_instance" "postgres" {

  identifier = "production-postgres"

  allocated_storage = 20

  engine         = "postgres"
  engine_version = "15"

  instance_class = "db.t3.micro"

  username = "postgres"
  password = var.db_password

  publicly_accessible = false

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  skip_final_snapshot = true
}

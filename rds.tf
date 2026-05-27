resource "aws_db_subnet_group" "main" {

  name = "main-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

resource "aws_security_group" "rds_sg" {

  name   = "rds-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.ecs_sg.id
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

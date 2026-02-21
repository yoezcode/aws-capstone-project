#Provides an RDS DB subnet group resource.

resource "aws_db_subnet_group" "wp" {
  name = "wp-db-subnets"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "wp" {
  identifier = "wordpress-db"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 10

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.wp.name
  vpc_security_group_ids = [aws_security_group.db.id]

  multi_az            = true
  publicly_accessible = false
  skip_final_snapshot = true

}
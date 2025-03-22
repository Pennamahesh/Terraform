data "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
}
resource "aws_db_subnet_group" "default" {
  name = "main"
  subnet_ids = [
    aws_subnet.public-subnet-terraform.id,
    aws_subnet.public-subnet-2-terraform.id

]
  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  identifier           = "testdb"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.39"
  instance_class       = "db.t3.medium"
  username             = "dbadmin"
  password             = data.aws_secretsmanager_secret_version.password.secret_string
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.default.id
}

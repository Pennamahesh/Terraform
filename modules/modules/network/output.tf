output "vpc_name" {
  value = var.vpc_name

}
output "vpc_id" {
  value = aws_vpc.terraform-vpc.id

}

output "public_subnet_id" {
  value = aws_subnet.public-subnet-terraform.*.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet-terraform.*.id
}

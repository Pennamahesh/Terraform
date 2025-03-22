# Configure the AWS Provider
provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket = "terraform-practice-penna"
    key    = "base-infra-ts.state"
    region = "us-east-1"
  }
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name = var.vpc_tag
  }
}

resource "aws_internet_gateway" "igw-terraform" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = var.igw-tag
  }
}

resource "aws_subnet" "public-subnet-terraform" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = var.subnet-cidr_block
  availability_zone = var.subnet_az

  tags = {
    Name = var.public-subnet-terraform-tag
  }
}

resource "aws_route_table" "public-rt-terra" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw-terraform.id
  }

  tags = {
    Name = var.public-rt-terra-tag
  }
}

resource "aws_route_table_association" "pub-rta-terra" {
  subnet_id      = aws_subnet.public-subnet-terraform.id
  route_table_id = aws_route_table.public-rt-terra.id
}

resource "aws_security_group" "allow_all" {
  name        = var.sg-name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"


  }
  tags = {
    Name = "allow_all"
  }
}


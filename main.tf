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
resource "aws_subnet" "public-subnet-2-terraform" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = var.subnet-cidr_block-2
  availability_zone = var.subnet_az-2

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
resource "aws_instance" "explict-dependency" {
  ami                         = "ami-085ad6ae776d8f09c"
  availability_zone           = var.subnet_az
  instance_type               = var.ec2_instance_type
  key_name                    = var.key-pair
  subnet_id                   = aws_subnet.public-subnet-terraform.id
  vpc_security_group_ids      = [aws_security_group.allow_all.id] # Must be a list
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name-33745328" # Replace with a unique bucket name
  acl    = "private"

  # Explicitly depend on the EC2 instance
  depends_on = [aws_instance.explict-dependency]

  tags = {
    Name        = "ExampleBucket"
    Environment = "Dev"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket = "terraform-practice-penna"
    key    = "functions.tfstate"
    region = "us-east-1"
  }
}


resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.vpc-cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    cost-center = local.cost-center
    team-dl     = local.team-dl
    environment = var.environment
  }
}




resource "aws_internet_gateway" "igw-terraform" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    cost-center = local.cost-center
    team-dl     = local.team-dl
    environment = var.environment

  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
terraform {
  backend "s3" {
    bucket = "terraform-practice-penna"
    key    = "production.tfstate"
    region = "us-east-1"
  }
}



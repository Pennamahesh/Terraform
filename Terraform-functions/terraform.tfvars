region             = "us-east-1"
vpc-cidr_block     = "10.0.0.0/16"
vpc_name           = "mahesh-vpc"
azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
public-cidr-block  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private-cidr-block = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
key-pair           = "key-pair-3"
environment        = "Prod"
amis = {
  us-east-1 = "ami-04b4f1a9cf54c11d0"
  us-east-2 = "ami-0fc82f4dabc05670b"
}
instance_type = "t2.micro"


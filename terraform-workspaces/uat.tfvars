cidr_block                  = "10.0.0.0/16"
region                      = "us-east-1"
vpc_tag                     = "Vpc-terra"
igw-tag                     = "igw-terra"
subnet-cidr_block           = "10.0.0.0/24"
subnet_az                   = "us-east-1a"
public-subnet-terraform-tag = "public-subnet-terraform"
rt_cidr_block               = "0.0.0.0/0"
public-rt-terra-tag         = "public-rt-terra"
sg-name                     = "allow-all"
ec2_az                      = "us-east-1a"
ec2_instance_type           = "t2.micro"
key-pair                    = "my-key-pair"
env                         = "uat"



# terraform apply --var-file ./uat.tfvars

module "compute" {
  source      = "../modules/compute"
  environment = "dev"
  amis = {
    us-east-1 = "ami-04b4f1a9cf54c11d0"
    us-east-2 = "ami-0fc82f4dabc05670b"
  }
  region        = "us-east-1"
  instance_type = "t2.micro"
  sg_id         = module.sg-development.sg_id
  subnets_id    = module.dev_vpc_1.public_subnet_id

}

module "elb" {
  source         = "../modules/elb"
  sg_id          = module.sg-development.sg_id
  subnets        = module.dev_vpc_1.public_subnet_id
  tgname         = "modules-demo"
  vpc_id         = module.dev_vpc_1.vpc_id
  environment    = "dev"
  public-servers = module.compute.instance-id



}

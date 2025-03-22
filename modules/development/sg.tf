module "sg-development" {
  source   = "../modules/sg"
  vpc_name = module.dev_vpc_1.vpc_name
  vpc_id   = module.dev_vpc_1.vpc_id


}

module "sg-production" {
  source   = "../modules/sg"
  vpc_name = module.production.vpc_name
  vpc_id   = module.production.vpc_id

}

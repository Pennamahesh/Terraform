module "production" {
  source             = "../modules/network"
  vpc_cidr_block     = "192.168.0.0/16"
  vpc_name           = "production"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public-cidr-block  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private-cidr-block = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  environment        = "production"

}

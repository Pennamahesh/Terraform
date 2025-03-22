module "dev_vpc_1" {
  source             = "../modules/network"
  vpc_cidr_block     = "10.0.0.0/16"
  vpc_name           = "mahesh-vpc"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public-cidr-block  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private-cidr-block = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  environment        = "development"

}

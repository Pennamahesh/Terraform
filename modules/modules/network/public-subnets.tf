resource "aws_subnet" "public-subnet-terraform" {
  count             = length(var.public-cidr-block)
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = element(var.public-cidr-block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    cost-center = local.cost-center
    team-dl     = local.team-dl
    environment = var.environment
  }
}

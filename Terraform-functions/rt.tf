resource "aws_route_table" "public-rt-terra" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-terraform.id
  }

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    cost-center = local.cost-center
    team-dl     = local.team-dl
    environment = var.environment

  }
}

resource "aws_route_table" "private-rt-terra" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name        = var.vpc_name
    Owner       = local.Owner
    cost-center = local.cost-center
    team-dl     = local.team-dl
    environment = var.environment

  }
}
resource "aws_route_table_association" "pub-rta-terra" {
  count          = length(var.public-cidr-block)
  subnet_id      = element(aws_subnet.public-subnet-terraform.*.id, count.index)
  route_table_id = aws_route_table.public-rt-terra.id
}
resource "aws_route_table_association" "pvt-rta-terra" {
  count          = length(var.private-cidr-block)
  subnet_id      = element(aws_subnet.private-subnet-terraform.*.id, count.index)
  route_table_id = aws_route_table.private-rt-terra.id
}

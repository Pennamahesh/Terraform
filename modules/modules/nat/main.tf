resource "aws_eip" "natgw-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw-eip.id
  subnet_id     = element(var.public_subnet--id, count.index)


}

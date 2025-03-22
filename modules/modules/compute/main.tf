resource "aws_instance" "public-servers" {
  #  count                       = length(var.public-cidr-block)
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = "key-pair-3"
  subnet_id                   = element(var.subnets_id, count.index)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true


}

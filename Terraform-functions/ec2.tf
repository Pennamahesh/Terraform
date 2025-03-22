resource "aws_instance" "terraform-functions" {
  #  count                       = length(var.public-cidr-block)
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = "key-pair-3"
  subnet_id                   = element(aws_subnet.public-subnet-terraform[*].id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"] # Must be a list
  associate_public_ip_address = true


}

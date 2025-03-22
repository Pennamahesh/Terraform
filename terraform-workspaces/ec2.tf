resource "aws_instance" "Workspaces" {
  ami                         = "ami-085ad6ae776d8f09c"
  availability_zone           = var.subnet_az
  instance_type               = var.ec2_instance_type
  key_name                    = var.key-pair # Corrected variable name
  subnet_id                   = aws_subnet.public-subnet-terraform.id
  vpc_security_group_ids      = [aws_security_group.allow_all.id] # Must be a list
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx
    echo "<h1>${var.env}-server-1</h1>" | sudo tee /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
    Name        = "Server-1"
    Env         = "Prod"
    Cost-center = "ABCD"
    Owner       = "mahesh"
  }
}

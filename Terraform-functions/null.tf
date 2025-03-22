resource "null_resource" "provisioners" {
  count = var.environment == "prod" ? 3 : 1

  provisioner "file" {
    source      = "C:/Users/alapu/Desktop/Terraform-functions/user-data.sh"
    destination = "/home/ubuntu/user-data.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx"
    ]
  }

  # Print instance public IP in Terraform console output
  provisioner "local-exec" {
    command = "echo Instance ${element(aws_instance.terraform-functions.*.public_ip, count.index)} is up!"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/alapu/Desktop/Terraform-functions/key-pair-3.pem")
    host        = element(aws_instance.terraform-functions.*.public_ip, count.index)
  }
}

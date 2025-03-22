output "instance-id" {
  value = aws_instance.public-servers.*.id
}

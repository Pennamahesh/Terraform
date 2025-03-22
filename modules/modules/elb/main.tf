resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnets

  enable_deletion_protection = true
}
resource "aws_lb_target_group" "test" {
  name     = var.tgname
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "test" {
  count            = var.environment == "Production" ? 3 : 3
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = element(var.public-servers, count.index)
  port             = 80
}

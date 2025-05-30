provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "alb" {
  name               = "shingi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]  
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "shingi-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attachments" {
  for_each = toset(var.ec2_instance_ids)

  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = each.key
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb" "eks" {
  name               = "${var.name}-alb"
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]
  subnets         = module.vpc.public_subnets
}

resource "aws_lb_listener" "http" {
  port     = "80"
  protocol = "HTTP"

  load_balancer_arn = aws_lb.eks.arn
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

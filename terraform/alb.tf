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

resource "aws_lb_listener_rule" "http_rule" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_target_group" "eks" {
  name = var.name
  port = 30000

  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port = 30000
    path = "/"
  }
}

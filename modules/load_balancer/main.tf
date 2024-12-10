resource "aws_lb" "main" {
  name               = "main-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [aws_security_group.rpj.id]


  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}


resource "aws_security_group" "rpj" {
  name        = "rpj"
  description = "Security group for load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

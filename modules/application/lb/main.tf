# target_groupの設定
resource "aws_lb_target_group" "lb_target" {
  name     = "${var.common.app_name}-lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each = var.instance_ids

  target_group_arn = aws_lb_target_group.lb_target.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb" "alb" {
  name               = "${var.common.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_web_ec2_id]
  subnets            = var.set_public_ids
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target.arn
    type             = "forward"
  }
}

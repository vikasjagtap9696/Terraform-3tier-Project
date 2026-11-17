resource "aws_launch_template" "web" {
    name_prefix = var.name_prefix
    image_id = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.sg_ids
    user_data = base64encode(var.user_data)
}


resource "aws_autoscaling_group" "web" {
  desired_capacity     = var.desired_capacity
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = var.subnets
  launch_template {
    id      = aws_launch_template.web.id
    version = var.launch_template_version
  }
  tag {
    key                 = var.name
    value               = var.value
    propagate_at_launch = var.propagate_at_launch
  }
}

resource "aws_lb" "web" {
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.alb_subnets
  security_groups    = [var.alb_sg_id]
}

resource "aws_lb_target_group" "web" {
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_check_path
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = var.default_type
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_autoscaling_attachment" "web_tg" {
  autoscaling_group_name = aws_autoscaling_group.web.name
  lb_target_group_arn   = aws_lb_target_group.web.arn
}

output "alb_dns" {
  value = aws_lb.web.dns_name
}
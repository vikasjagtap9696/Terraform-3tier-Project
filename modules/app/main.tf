resource "aws_launch_template" "app" {
  name_prefix            = var.name_prefix
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.sg_ids
  user_data              = base64encode(var.user_data)
}

resource "aws_autoscaling_group" "app" {
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.app.id
    version = var.launch_template_version
  }

  tag {
    key                 = var.key
    value               = var.value
    propagate_at_launch = var.propagate_at_launch
  }
}

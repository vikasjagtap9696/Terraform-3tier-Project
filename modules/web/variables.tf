variable "name_prefix" {
  type    = string
  default = "web-"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "user_data" {
  type    = string
  default = "#!/bin/bash\nyum install -y httpd\nsystemctl start httpd\n"
}

variable "desired_capacity" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "subnets" {
  type = list(string)
}

variable "launch_template_version" {
  type    = string
  default = "$Latest"
}

variable "name" {
  type    = string
  default = "Name"
}

variable "value" {
  type    = string
  default = "web"
}

variable "propagate_at_launch" {
  type    = bool
  default = true
}

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "alb_subnets" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "tg_port" {
  type    = number
  default = 80
}

variable "tg_protocol" {
  type    = string
  default = "HTTP"
}

variable "vpc_id" {
  type = string
}

variable "default_type" {
  type    = string
  default = "forward"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}
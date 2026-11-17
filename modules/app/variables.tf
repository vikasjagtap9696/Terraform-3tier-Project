variable "vpc_id" {
  type = string
}

variable "name_prefix" {
  type    = string
  default = "app-"
}

variable "subnets" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "user_data" {
  type    = string
  default = "#!/bin/bash\nyum install -y python3\n"
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

variable "version" {
  type    = string
  default = "$Latest"
}

variable "key" {
  type    = string
  default = "Name"
}

variable "value" {
  type    = string
  default = "app"
}

variable "propagate_at_launch" {
  type    = bool
  default = true
}

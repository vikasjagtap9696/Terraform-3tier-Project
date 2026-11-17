variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "route_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "web_sg_name" {
  type    = string
  default = "web-sg"
}

variable "web_alb_sg_name" {
  type    = string
  default = "web-alb-sg"
}

variable "app_sg_name" {
  type    = string
  default = "app-sg"
}

variable "db_sg_name" {
  type    = string
  default = "db-sg"
}

variable "web_from_port" {
  type    = number
  default = 80
}

variable "web_to_port" {
  type    = number
  default = 80
}

variable "web_protocol" {
  type    = string
  default = "tcp"
}

variable "web_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "web_alb_from_port" {
  type    = number
  default = 80
}

variable "web_alb_to_port" {
  type    = number
  default = 80
}

variable "web_alb_protocol" {
  type    = string
  default = "tcp"
}

variable "web_alb_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "app_from_port" {
  type    = number
  default = 8080
}

variable "app_to_port" {
  type    = number
  default = 8080
}

variable "app_protocol" {
  type    = string
  default = "tcp"
}

variable "db_from_port" {
  type    = number
  default = 3306
}

variable "db_to_port" {
  type    = number
  default = 3306
}

variable "db_protocol" {
  type    = string
  default = "tcp"
}

variable "egress_from_port" {
  type    = number
  default = 0
}

variable "egress_to_port" {
  type    = number
  default = 0
}

variable "egress_protocol" {
  type    = string
  default = "-1"
}

variable "egress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

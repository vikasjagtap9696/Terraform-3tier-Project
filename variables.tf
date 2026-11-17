variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "web_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "web_ami_id" {
  type = string
}

variable "web_desired_capacity" {
  type    = number
  default = 2
}

variable "web_min_size" {
  type    = number
  default = 2
}

variable "web_max_size" {
  type    = number
  default = 4
}

variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_ami_id" {
  type = string
}

variable "app_desired_capacity" {
  type    = number
  default = 2
}

variable "app_min_size" {
  type    = number
  default = 2
}

variable "app_max_size" {
  type    = number
  default = 4
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type    = string
  default = "production"
}

variable "db_multi_az" {
  type    = bool
  default = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "name" {
  type    = string
  default = "integration-argoworkflow"
}

variable "ingress_ports" {
  default = [80]
}

variable "ip_address" {
  type = string
}

variable "rolearn" {
  type = string
}

variable "username" {
  type = string
}

variable "mysql_password" {
  type = string
}

variable "mysql_username" {
  type = string
}

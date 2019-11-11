variable "region" {
  default = "ap-east-1"
}
variable "vpc_id" {
  default = "vpc-0150c0d7604707d14"
}
variable "public_cidr" {
  type = "list"
  default = ["10.128.121.0/24","10.128.122.0/24"]
}
variable "privated_cidr" {
  type = "list"
  default = ["10.128.123.0/24","10.128.124.0/24"]
}
variable "securitygroup_in" {
  type = "list"
  default = [,"ken_privated","ken_web_wb"]
}
variable "securitygroup_out" {
  type = "list"
  default = ["ken_public","ken_web_lb"]
}
variable "sg_port" {
  type = "list"
  default = ["22","80"]
}
variable "ami" {
  default = "ami-f8ee9589"
}
variable "az" {
  default = ["ap-east-1b", "ap-east-1c"]
}


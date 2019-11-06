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
variable "ec2_ami" {
  default = "ami-f8ee9589"
}

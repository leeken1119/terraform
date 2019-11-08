#查詢VPC ID
data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

data "aws_internet_gateway" "igw" {
  tags {
	Name = "josh_P-3"
  }
}
#建立2個public subnet
resource "aws_subnet" "public" {
  count = "2"
  vpc_id            = "${data.aws_vpc.vpc.id}"
  availability_zone = "${element(var.az,count.index)}"
  map_public_ip_on_launch = "true"
  cidr_block        = "${element(var.public_cidr,count.index)}"
  tags = {
    Name = "ken_public_${count.index+1}"
    tf = "test"
  }
}

#建立2個privated subnet
resource "aws_subnet" "privated" {
  count = "2"
  vpc_id            = "${data.aws_vpc.vpc.id}"
  availability_zone = "${element(var.az,count.index)}"
  cidr_block        = "${element(var.privated_cidr,count.index)}"
  tags = {
    Name = "ken_privated_${count.index+1}"
    tf = "test"
  }
}
#建立route table for public
resource "aws_route_table" "public_route" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = "${data.aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "ken_public_rf1"
    tf = "test"
  }
}
#建立route table for privated
resource "aws_route_table" "privated_route" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  count = "2"
  route {
	cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${element(aws_nat_gateway.ngw.*.id,count.index)}"
}

  tags = {
    Name = "ken_privated_rf${count.index+1}"
    tf = "test"
  }
}
#route table 與 subnet 連接
resource "aws_route_table_association" "public_subrt" {
  count = "2"
  subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
  route_table_id = "${aws_route_table.public_route.id}"
}
resource "aws_route_table_association" "privated_subrt" {
  count = "2"
  subnet_id = "${element(aws_subnet.privated.*.id,count.index)}"
  route_table_id = "${element(aws_route_table.privated_route.*.id,count.index)}"
}


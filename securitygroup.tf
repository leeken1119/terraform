resource "aws_security_group" "sg_in" {
  name = "${element(var.securitygroup_in,count.index)}"
  description = "tf lab"
  vpc_id = "${data.aws_vpc.vpc.id}"
  count = "${length(var.securitygroup_in)}"
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${element(var.securitygroup_in,count.index)}_sg"
    tf = "test"
  }
}
resource "aws_security_group" "sg_out" {
  name = "${element(var.securitygroup_out,count.index)}"
  description = "tf lab"
  vpc_id = "${data.aws_vpc.vpc.id}"
  count = "${length(var.securitygroup_out)}"
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${element(var.securitygroup_out,count.index)}_sg"
    tf = "test"
  }
}
resource "aws_security_group_rule" "out_rule" {
  count = "${length(var.sg_port)}"
  type = "ingress"
  from_port = "${element(var.sg_port,count.index)}"
  to_port = "${element(var.sg_port,count.index)}"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${element(aws_security_group.sg_out.*.id,count.index)}"
}
resource "aws_security_group_rule" "in_rule" {
  count = "${length(var.sg_port)}"
  type = "ingress"
  from_port = "${element(var.sg_port,count.index)}"
  to_port = "${element(var.sg_port,count.index)}"
  protocol = "tcp"
  security_group_id = "${element(aws_security_group.sg_in.*.id,count.index)}"
  source_security_group_id = "${element(aws_security_group.sg_out.*.id,count.index)}"
}


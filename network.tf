#resource "aws_network_interface" "public" {
#  subnet_id = "${element(aws_subnet.public.*.id,1)}"
#  security_groups = ["${element(aws_security_group.sg_in.*.id,1)}"]
  
#  tags = {
#	Name = "ken_public_int"
#	tf = "test"
#  }
#}
resource "aws_nat_gateway" "ngw" {
  count = "2"
  allocation_id = "${element(aws_eip.eip.*.id,count.index)}"
  subnet_id = "${element(aws_subnet.public.*.id,count.index)}"

  tags = {
	Name = "ken_nat${count.index+1}"
  }
}
resource "aws_eip" "eip" {
  count = "2"
  vpc = true

  tags = {
	Name = "ken_eip${count.index+1}"
  }
}

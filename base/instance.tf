resource "aws_instance" "bastion" {
  ami = "${var.ami}"
  instance_type = "t3.micro"
  iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}"
  subnet_id = "${element(aws_subnet.public.*.id,2)}"
  security_groups = ["${element(aws_security_group.sg_out.*.id,2)}"]

  associate_public_ip_address = "true"
  key_name = "Kentest"

  tags {
  Name = "ken_bastion"
  tf = "test"
  }
}
resource "aws_instance" "web" {
  count = "2"
  ami = "${var.ami}"
  instance_type = "t3.micro"
  iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}"
  subnet_id = "${element(aws_subnet.privated.*.id,2)}"
  user_data = "${file("data.sh")}"

  key_name = "Kentest"
  security_groups = [
	"${element(aws_security_group.sg_in.*.id,2)}",
	"${element(aws_security_group.sg_in.*.id,1)}"
]

tags {
  Name = "ken_web${count.index+1}"
  tf = "test"
  }
}
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = "${aws_iam_role.ec2-web-role.name}"
}

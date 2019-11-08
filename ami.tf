data "aws_instance" "web" {
  filter {
	name = "tag:Name"
	values = ["ken_web1"]
  }
}
data "aws_ebs_volume" "ebs" {
  most_recent = true
  
  filter {
	name = "attachment.instance-id"
	values = ["${data.aws_instance.web.id}"]
  }
}
resource "aws_ebs_snapshot" "snap" {
  volume_id = "${data.aws_ebs_volume.ebs.id}"

  tags = {
	Name = "ken_web_snap"
	tf = "test"
  }
}
resource "aws_ami" "ami" {
  name = "ken_web_ami"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  
  ebs_block_device {
	device_name = "/dev/xvda"
	snapshot_id = "${aws_ebs_snapshot.snap.id}"
  }
  tags = {
	Name = "ken_web_ami"
  }
}

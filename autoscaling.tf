resource "aws_launch_configuration" "as_conf" {
  name = "ken_web_config"
  image_id      = "${aws_ami.ami.id}"
  instance_type = "t3.mirco"
  iam_instance_profile = "${aws_iam_instance_profile.bastion_profile.name}"
  security_groups = ["${aws_security_group.sg_in.*.id}"]
}

resource "aws_autoscaling_group" "asg" {
  name = "ken_asg"
  max_size = 2
  min_size = 1
  health_check_type = "ELB"
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier  = ["${element(aws_subnet.privated.*.id,0)}","${element(aws_subnet.privated.*.id,1)}"]
  load_balancers = ["${aws_elb.elb.id}"]
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

  tags = {
	Name = "ken_asg"
}
}

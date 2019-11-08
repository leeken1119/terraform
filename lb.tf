resource "aws_elb" "elb" {
  name = "ken-elb"
  subnets = ["${element(aws_subnet.public.*.id,0)}","${element(aws_subnet.public.*.id,1)}"]
  listener {
		instance_port = 80
		instance_protocol = "tcp"
		lb_port = 80
		lb_protocol = "tcp"
	}
  health_check {
	healthy_threshold   = 2
	unhealthy_threshold = 2
	timeout             = 5
   	target              = "HTTP:80/host.php"
    	interval            = 10
  }
  security_groups = ["${element(aws_security_group.sg_out.*.id,1)}"]
  tags = {
	Name = "ken_elb"
  }
}

resource "aws_elb_attachment" "elb-att1" {
  elb = "${aws_elb.elb.id}"
  instance = "${element(aws_instance.web.*.id,1)}"
}
resource "aws_elb_attachment" "elb-att2" {
  elb = "${aws_elb.elb.id}"
  instance = "${element(aws_instance.web.*.id,2)}"
}


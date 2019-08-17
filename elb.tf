resource "aws_elb" "api-kubelevent-com" {
  name = "api-kubelevent-com-4c32oj"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-kubelevent-com.id}"]
  subnets         = ["${aws_subnet.utility-us-west-2a-kubelevent-com.id}", "${aws_subnet.utility-us-west-2b-kubelevent-com.id}", "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "api.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_elb" "bastion-kubelevent-com" {
  name = "bastion-kubelevent-com-1ugl25"

  listener = {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.bastion-elb-kubelevent-com.id}"]
  subnets         = ["${aws_subnet.utility-us-west-2a-kubelevent-com.id}", "${aws_subnet.utility-us-west-2b-kubelevent-com.id}", "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"]

  health_check = {
    target              = "TCP:22"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "bastion.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

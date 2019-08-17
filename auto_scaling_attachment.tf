resource "aws_autoscaling_attachment" "bastions-kubelevent-com" {
  elb                    = "${aws_elb.bastion-kubelevent-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.bastions-kubelevent-com.id}"
}

resource "aws_autoscaling_attachment" "master-us-west-2a-masters-kubelevent-com" {
  elb                    = "${aws_elb.api-kubelevent-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-west-2a-masters-kubelevent-com.id}"
}

resource "aws_autoscaling_attachment" "master-us-west-2b-masters-kubelevent-com" {
  elb                    = "${aws_elb.api-kubelevent-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-west-2b-masters-kubelevent-com.id}"
}

resource "aws_autoscaling_attachment" "master-us-west-2c-masters-kubelevent-com" {
  elb                    = "${aws_elb.api-kubelevent-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-west-2c-masters-kubelevent-com.id}"
}
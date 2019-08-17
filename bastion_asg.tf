resource "aws_autoscaling_group" "bastions-kubelevent-com" {
  name                 = "bastions.kubelevent.com"
  launch_configuration = "${aws_launch_configuration.bastions-kubelevent-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.utility-us-west-2a-kubelevent-com.id}", "${aws_subnet.utility-us-west-2b-kubelevent-com.id}", "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "bastions.kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "bastions"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/bastion"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}
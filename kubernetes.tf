output "bastion_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.bastions-kubelevent-com.id}"]
}

output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-kubelevent-com.id}"]
}

output "bastions_role_arn" {
  value = "${aws_iam_role.bastions-kubelevent-com.arn}"
}

output "bastions_role_name" {
  value = "${aws_iam_role.bastions-kubelevent-com.name}"
}

output "cluster_name" {
  value = "kubelevent.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-west-2a-masters-kubelevent-com.id}", "${aws_autoscaling_group.master-us-west-2b-masters-kubelevent-com.id}", "${aws_autoscaling_group.master-us-west-2c-masters-kubelevent-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kubelevent-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kubelevent-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kubelevent-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kubelevent-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kubelevent-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-2a-kubelevent-com.id}", "${aws_subnet.us-west-2b-kubelevent-com.id}", "${aws_subnet.us-west-2c-kubelevent-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kubelevent-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kubelevent-com.name}"
}

output "region" {
  value = "us-west-2"
}

output "route_table_private-us-west-2a_id" {
  value = "${aws_route_table.private-us-west-2a-kubelevent-com.id}"
}

output "route_table_private-us-west-2b_id" {
  value = "${aws_route_table.private-us-west-2b-kubelevent-com.id}"
}

output "route_table_private-us-west-2c_id" {
  value = "${aws_route_table.private-us-west-2c-kubelevent-com.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.kubelevent-com.id}"
}

output "subnet_us-west-2a_id" {
  value = "${aws_subnet.us-west-2a-kubelevent-com.id}"
}

output "subnet_us-west-2b_id" {
  value = "${aws_subnet.us-west-2b-kubelevent-com.id}"
}

output "subnet_us-west-2c_id" {
  value = "${aws_subnet.us-west-2c-kubelevent-com.id}"
}

output "subnet_utility-us-west-2a_id" {
  value = "${aws_subnet.utility-us-west-2a-kubelevent-com.id}"
}

output "subnet_utility-us-west-2b_id" {
  value = "${aws_subnet.utility-us-west-2b-kubelevent-com.id}"
}

output "subnet_utility-us-west-2c_id" {
  value = "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kubelevent-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kubelevent-com.id}"
}

provider "aws" {
  region = "us-west-2"
}

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

resource "aws_autoscaling_group" "master-us-west-2a-masters-kubelevent-com" {
  name                 = "master-us-west-2a.masters.kubelevent.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-2a-masters-kubelevent-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-kubelevent-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2a.masters.kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-2a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-west-2b-masters-kubelevent-com" {
  name                 = "master-us-west-2b.masters.kubelevent.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-2b-masters-kubelevent-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2b-kubelevent-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2b.masters.kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-2b"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-west-2c-masters-kubelevent-com" {
  name                 = "master-us-west-2c.masters.kubelevent.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-2c-masters-kubelevent-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2c-kubelevent-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2c.masters.kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-2c"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kubelevent-com" {
  name                 = "nodes.kubelevent.com"
  launch_configuration = "${aws_launch_configuration.nodes-kubelevent-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-kubelevent-com.id}", "${aws_subnet.us-west-2b-kubelevent-com.id}", "${aws_subnet.us-west-2c-kubelevent-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kubelevent.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-kubelevent-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "a.etcd-events.kubelevent.com"
    "k8s.io/etcd/events"                   = "a/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kubelevent-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "a.etcd-main.kubelevent.com"
    "k8s.io/etcd/main"                     = "a/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-events-kubelevent-com" {
  availability_zone = "us-west-2b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "b.etcd-events.kubelevent.com"
    "k8s.io/etcd/events"                   = "b/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-main-kubelevent-com" {
  availability_zone = "us-west-2b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "b.etcd-main.kubelevent.com"
    "k8s.io/etcd/main"                     = "b/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-events-kubelevent-com" {
  availability_zone = "us-west-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "c.etcd-events.kubelevent.com"
    "k8s.io/etcd/events"                   = "c/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-main-kubelevent-com" {
  availability_zone = "us-west-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "c.etcd-main.kubelevent.com"
    "k8s.io/etcd/main"                     = "c/a,b,c"
    "k8s.io/role/master"                   = "1"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_eip" "us-west-2a-kubelevent-com" {
  vpc = true

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2a.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_eip" "us-west-2b-kubelevent-com" {
  vpc = true

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2b.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_eip" "us-west-2c-kubelevent-com" {
  vpc = true

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2c.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

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

resource "aws_iam_instance_profile" "bastions-kubelevent-com" {
  name = "bastions.kubelevent.com"
  role = "${aws_iam_role.bastions-kubelevent-com.name}"
}

resource "aws_iam_instance_profile" "masters-kubelevent-com" {
  name = "masters.kubelevent.com"
  role = "${aws_iam_role.masters-kubelevent-com.name}"
}

resource "aws_iam_instance_profile" "nodes-kubelevent-com" {
  name = "nodes.kubelevent.com"
  role = "${aws_iam_role.nodes-kubelevent-com.name}"
}

resource "aws_iam_role" "bastions-kubelevent-com" {
  name               = "bastions.kubelevent.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_bastions.kubelevent.com_policy")}"
}

resource "aws_iam_role" "masters-kubelevent-com" {
  name               = "masters.kubelevent.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kubelevent.com_policy")}"
}

resource "aws_iam_role" "nodes-kubelevent-com" {
  name               = "nodes.kubelevent.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kubelevent.com_policy")}"
}

resource "aws_iam_role_policy" "bastions-kubelevent-com" {
  name   = "bastions.kubelevent.com"
  role   = "${aws_iam_role.bastions-kubelevent-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_bastions.kubelevent.com_policy")}"
}

resource "aws_iam_role_policy" "masters-kubelevent-com" {
  name   = "masters.kubelevent.com"
  role   = "${aws_iam_role.masters-kubelevent-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kubelevent.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-kubelevent-com" {
  name   = "nodes.kubelevent.com"
  role   = "${aws_iam_role.nodes-kubelevent-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kubelevent.com_policy")}"
}

resource "aws_internet_gateway" "kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba" {
  key_name   = "kubernetes.kubelevent.com-7a:19:36:aa:43:6f:43:e2:b1:39:d7:47:cf:11:3c:ba"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kubelevent.com-7a1936aa436f43e2b139d747cf113cba_public_key")}"
}

resource "aws_launch_configuration" "bastions-kubelevent-com" {
  name_prefix                 = "bastions.kubelevent.com-"
  image_id                    = "ami-0d8618ba6320df983"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastions-kubelevent-com.id}"
  security_groups             = ["${aws_security_group.bastion-kubelevent-com.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 32
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-west-2a-masters-kubelevent-com" {
  name_prefix                 = "master-us-west-2a.masters.kubelevent.com-"
  image_id                    = "ami-0d8618ba6320df983"
  instance_type               = "m4.large"
  key_name                    = "${aws_key_pair.kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubelevent-com.id}"
  security_groups             = ["${aws_security_group.masters-kubelevent-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2a.masters.kubelevent.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-west-2b-masters-kubelevent-com" {
  name_prefix                 = "master-us-west-2b.masters.kubelevent.com-"
  image_id                    = "ami-0d8618ba6320df983"
  instance_type               = "m4.large"
  key_name                    = "${aws_key_pair.kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubelevent-com.id}"
  security_groups             = ["${aws_security_group.masters-kubelevent-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2b.masters.kubelevent.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-west-2c-masters-kubelevent-com" {
  name_prefix                 = "master-us-west-2c.masters.kubelevent.com-"
  image_id                    = "ami-0d8618ba6320df983"
  instance_type               = "m4.large"
  key_name                    = "${aws_key_pair.kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubelevent-com.id}"
  security_groups             = ["${aws_security_group.masters-kubelevent-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2c.masters.kubelevent.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kubelevent-com" {
  name_prefix                 = "nodes.kubelevent.com-"
  image_id                    = "ami-0d8618ba6320df983"
  instance_type               = "m4.large"
  key_name                    = "${aws_key_pair.kubernetes-kubelevent-com-7a1936aa436f43e2b139d747cf113cba.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kubelevent-com.id}"
  security_groups             = ["${aws_security_group.nodes-kubelevent-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kubelevent.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "us-west-2a-kubelevent-com" {
  allocation_id = "${aws_eip.us-west-2a-kubelevent-com.id}"
  subnet_id     = "${aws_subnet.utility-us-west-2a-kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2a.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_nat_gateway" "us-west-2b-kubelevent-com" {
  allocation_id = "${aws_eip.us-west-2b-kubelevent-com.id}"
  subnet_id     = "${aws_subnet.utility-us-west-2b-kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2b.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_nat_gateway" "us-west-2c-kubelevent-com" {
  allocation_id = "${aws_eip.us-west-2c-kubelevent-com.id}"
  subnet_id     = "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2c.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kubelevent-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kubelevent-com.id}"
}

resource "aws_route" "private-us-west-2a-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-west-2a-kubelevent-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-west-2a-kubelevent-com.id}"
}

resource "aws_route" "private-us-west-2b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-west-2b-kubelevent-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-west-2b-kubelevent-com.id}"
}

resource "aws_route" "private-us-west-2c-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-west-2c-kubelevent-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-west-2c-kubelevent-com.id}"
}

resource "aws_route53_record" "api-kubelevent-com" {
  name = "api.kubelevent.com"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-kubelevent-com.dns_name}"
    zone_id                = "${aws_elb.api-kubelevent-com.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z10P8P3T73BLI6"
}

resource "aws_route53_record" "bastion-kubelevent-com" {
  name = "bastion.kubelevent.com"
  type = "A"

  alias = {
    name                   = "${aws_elb.bastion-kubelevent-com.dns_name}"
    zone_id                = "${aws_elb.bastion-kubelevent-com.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z10P8P3T73BLI6"
}

resource "aws_route53_zone_association" "Z10P8P3T73BLI6" {
  zone_id = "/hostedzone/Z10P8P3T73BLI6"
  vpc_id  = "${aws_vpc.kubelevent-com.id}"
}

resource "aws_route_table" "kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/kops/role"              = "public"
  }
}

resource "aws_route_table" "private-us-west-2a-kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "private-us-west-2a.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/kops/role"              = "private-us-west-2a"
  }
}

resource "aws_route_table" "private-us-west-2b-kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "private-us-west-2b.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/kops/role"              = "private-us-west-2b"
  }
}

resource "aws_route_table" "private-us-west-2c-kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "private-us-west-2c.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/kops/role"              = "private-us-west-2c"
  }
}

resource "aws_route_table_association" "private-us-west-2a-kubelevent-com" {
  subnet_id      = "${aws_subnet.us-west-2a-kubelevent-com.id}"
  route_table_id = "${aws_route_table.private-us-west-2a-kubelevent-com.id}"
}

resource "aws_route_table_association" "private-us-west-2b-kubelevent-com" {
  subnet_id      = "${aws_subnet.us-west-2b-kubelevent-com.id}"
  route_table_id = "${aws_route_table.private-us-west-2b-kubelevent-com.id}"
}

resource "aws_route_table_association" "private-us-west-2c-kubelevent-com" {
  subnet_id      = "${aws_subnet.us-west-2c-kubelevent-com.id}"
  route_table_id = "${aws_route_table.private-us-west-2c-kubelevent-com.id}"
}

resource "aws_route_table_association" "utility-us-west-2a-kubelevent-com" {
  subnet_id      = "${aws_subnet.utility-us-west-2a-kubelevent-com.id}"
  route_table_id = "${aws_route_table.kubelevent-com.id}"
}

resource "aws_route_table_association" "utility-us-west-2b-kubelevent-com" {
  subnet_id      = "${aws_subnet.utility-us-west-2b-kubelevent-com.id}"
  route_table_id = "${aws_route_table.kubelevent-com.id}"
}

resource "aws_route_table_association" "utility-us-west-2c-kubelevent-com" {
  subnet_id      = "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"
  route_table_id = "${aws_route_table.kubelevent-com.id}"
}

resource "aws_security_group" "api-elb-kubelevent-com" {
  name        = "api-elb.kubelevent.com"
  vpc_id      = "${aws_vpc.kubelevent-com.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "api-elb.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_security_group" "bastion-elb-kubelevent-com" {
  name        = "bastion-elb.kubelevent.com"
  vpc_id      = "${aws_vpc.kubelevent-com.id}"
  description = "Security group for bastion ELB"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "bastion-elb.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_security_group" "bastion-kubelevent-com" {
  name        = "bastion.kubelevent.com"
  vpc_id      = "${aws_vpc.kubelevent-com.id}"
  description = "Security group for bastion"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "bastion.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_security_group" "masters-kubelevent-com" {
  name        = "masters.kubelevent.com"
  vpc_id      = "${aws_vpc.kubelevent-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "masters.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_security_group" "nodes-kubelevent-com" {
  name        = "nodes.kubelevent.com"
  vpc_id      = "${aws_vpc.kubelevent-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "nodes.kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.masters-kubelevent-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.masters-kubelevent-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-kubelevent-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-kubelevent-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-elb-kubelevent-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-to-master-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.bastion-kubelevent-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "bastion-to-node-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.bastion-kubelevent-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-kubelevent-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.api-elb-kubelevent-com.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-kubelevent-com.id}"
  from_port         = 3
  to_port           = 4
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kubelevent-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubelevent-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-elb-to-bastion" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.bastion-kubelevent-com.id}"
  source_security_group_id = "${aws_security_group.bastion-elb-kubelevent-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-bastion-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.bastion-elb-kubelevent-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-2a-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-2a"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2a.kubelevent.com"
    SubnetType                             = "Private"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

resource "aws_subnet" "us-west-2b-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-west-2b"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2b.kubelevent.com"
    SubnetType                             = "Private"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

resource "aws_subnet" "us-west-2c-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.96.0/19"
  availability_zone = "us-west-2c"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "us-west-2c.kubelevent.com"
    SubnetType                             = "Private"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/internal-elb"      = "1"
  }
}

resource "aws_subnet" "utility-us-west-2a-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.0.0/22"
  availability_zone = "us-west-2a"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "utility-us-west-2a.kubelevent.com"
    SubnetType                             = "Utility"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/elb"               = "1"
  }
}

resource "aws_subnet" "utility-us-west-2b-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.4.0/22"
  availability_zone = "us-west-2b"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "utility-us-west-2b.kubelevent.com"
    SubnetType                             = "Utility"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/elb"               = "1"
  }
}

resource "aws_subnet" "utility-us-west-2c-kubelevent-com" {
  vpc_id            = "${aws_vpc.kubelevent-com.id}"
  cidr_block        = "172.20.8.0/22"
  availability_zone = "us-west-2c"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "utility-us-west-2c.kubelevent.com"
    SubnetType                             = "Utility"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
    "kubernetes.io/role/elb"               = "1"
  }
}

resource "aws_vpc" "kubelevent-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kubelevent-com" {
  domain_name         = "us-west-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kubelevent-com" {
  vpc_id          = "${aws_vpc.kubelevent-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubelevent-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}

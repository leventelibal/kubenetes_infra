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
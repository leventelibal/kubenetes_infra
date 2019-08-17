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

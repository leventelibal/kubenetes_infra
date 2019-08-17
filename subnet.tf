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
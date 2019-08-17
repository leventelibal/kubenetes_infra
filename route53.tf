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
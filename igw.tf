
resource "aws_internet_gateway" "kubelevent-com" {
  vpc_id = "${aws_vpc.kubelevent-com.id}"

  tags = {
    KubernetesCluster                      = "kubelevent.com"
    Name                                   = "kubelevent.com"
    "kubernetes.io/cluster/kubelevent.com" = "owned"
  }
}
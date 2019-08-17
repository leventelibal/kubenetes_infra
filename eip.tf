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

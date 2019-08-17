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

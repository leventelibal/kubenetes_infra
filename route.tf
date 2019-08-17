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

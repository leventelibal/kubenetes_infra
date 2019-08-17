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
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

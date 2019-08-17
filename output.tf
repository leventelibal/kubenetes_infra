output "bastion_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.bastions-kubelevent-com.id}"]
}

output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-kubelevent-com.id}"]
}

output "bastions_role_arn" {
  value = "${aws_iam_role.bastions-kubelevent-com.arn}"
}

output "bastions_role_name" {
  value = "${aws_iam_role.bastions-kubelevent-com.name}"
}

output "cluster_name" {
  value = "kubelevent.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-west-2a-masters-kubelevent-com.id}", "${aws_autoscaling_group.master-us-west-2b-masters-kubelevent-com.id}", "${aws_autoscaling_group.master-us-west-2c-masters-kubelevent-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kubelevent-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kubelevent-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kubelevent-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kubelevent-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kubelevent-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-2a-kubelevent-com.id}", "${aws_subnet.us-west-2b-kubelevent-com.id}", "${aws_subnet.us-west-2c-kubelevent-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kubelevent-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kubelevent-com.name}"
}

output "region" {
  value = "us-west-2"
}

output "route_table_private-us-west-2a_id" {
  value = "${aws_route_table.private-us-west-2a-kubelevent-com.id}"
}

output "route_table_private-us-west-2b_id" {
  value = "${aws_route_table.private-us-west-2b-kubelevent-com.id}"
}

output "route_table_private-us-west-2c_id" {
  value = "${aws_route_table.private-us-west-2c-kubelevent-com.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.kubelevent-com.id}"
}

output "subnet_us-west-2a_id" {
  value = "${aws_subnet.us-west-2a-kubelevent-com.id}"
}

output "subnet_us-west-2b_id" {
  value = "${aws_subnet.us-west-2b-kubelevent-com.id}"
}

output "subnet_us-west-2c_id" {
  value = "${aws_subnet.us-west-2c-kubelevent-com.id}"
}

output "subnet_utility-us-west-2a_id" {
  value = "${aws_subnet.utility-us-west-2a-kubelevent-com.id}"
}

output "subnet_utility-us-west-2b_id" {
  value = "${aws_subnet.utility-us-west-2b-kubelevent-com.id}"
}

output "subnet_utility-us-west-2c_id" {
  value = "${aws_subnet.utility-us-west-2c-kubelevent-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kubelevent-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kubelevent-com.id}"
}
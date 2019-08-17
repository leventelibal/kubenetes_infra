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

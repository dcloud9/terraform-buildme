resource "aws_route_table_association" "rtba" {
  count          = "${length(var.subnets)}"
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.rtb.id}"
}

# Route Table ID
output "route_table_id" {
  value = "${aws_route_table.rtb.id}"
}

# NACL ID
output "network_acl_id" {
  value = "${aws_network_acl.acl.id}"
}

# Subnet IDs
output "subnet_ids" {
  value = ["${aws_subnet.subnet.*.id}"]
}

# Route egress traffic to Internet via ENI of NAT GW1
# Disable/set count = 0 in case of AZ1 Zone failure and need to reroute traffic to NAT GW2
resource "aws_route" "route_private1_natgw1_Internet" {
  count                  = "${var.active == "AZ1" ? 1 : 0}"
  route_table_id         = "${data.terraform_remote_state.network.private1_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = "${aws_nat_gateway.gw1.network_interface_id}"
}

resource "aws_route" "route_private2_natgw1_Internet" {
  count                  = "${var.active == "AZ1" ? 1 : 0}"
  route_table_id         = "${data.terraform_remote_state.network.private2_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = "${aws_nat_gateway.gw1.network_interface_id}"
}

# Route egress traffic to Internet via ENI of NAT GW2
# Enable/set count = 1 in case of AZ1 Zone failure and need to reroute traffic to NAT GW2
resource "aws_route" "route_private1_natgw2_Internet" {
  count                  = "${var.active == "AZ2" ? 1 : 0}"
  route_table_id         = "${data.terraform_remote_state.network.private1_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = "${aws_nat_gateway.gw2.network_interface_id}"
}

resource "aws_route" "route_private2_natgw2_Internet" {
  count                  = "${var.active == "AZ2" ? 1 : 0}"
  route_table_id         = "${data.terraform_remote_state.network.private2_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = "${aws_nat_gateway.gw2.network_interface_id}"
}

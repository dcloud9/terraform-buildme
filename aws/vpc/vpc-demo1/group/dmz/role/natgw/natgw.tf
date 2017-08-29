# Disable/set count = 0 in case of AZ1 Zone failure and need to reassociate EIP.
resource "aws_nat_gateway" "gw1" {
  count         = "${var.active == "AZ1" ? 1 : 0}"
  subnet_id     = "${element(data.terraform_remote_state.network.public1_subnet_ids, 0)}"
  allocation_id = "${aws_eip.eip.id}"
}

# Enable/set count = 1 in case of AZ1 Zone failure and need to reassociate EIP.
resource "aws_nat_gateway" "gw2" {
  count         = "${var.active == "AZ2" ? 1 : 0}"
  subnet_id     = "${element(data.terraform_remote_state.network.public1_subnet_ids, 1)}"
  allocation_id = "${aws_eip.eip.id}"
}

# Attach EIP to either NAT GW1 or GW2
resource "aws_eip" "eip" {
  vpc = true
}

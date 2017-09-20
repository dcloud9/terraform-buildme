resource "aws_network_acl" "acl" {
  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.subnet.*.id}"]

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "acl-${var.subnet_type}-${var.environment}-${var.environment_vpc}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"
}

resource "aws_network_acl_rule" "acl_ingress_all" {
  network_acl_id = "${aws_network_acl.acl.id}"
  rule_number    = 100
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "acl_all_egress" {
  network_acl_id = "${aws_network_acl.acl.id}"
  rule_number    = 100
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

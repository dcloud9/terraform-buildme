resource "aws_security_group" "sg-group" {
  description = "group-${var.environment}-${var.environment_vpc}-${var.environment_group} Group Security Group"
  name        = "sgrp-${var.environment}-${var.environment_vpc}-${var.environment_group}"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sg-${var.environment}-${var.environment_vpc}-${var.environment_group}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"

  lifecycle {
    create_before_destroy = true
  }
}

# Allow all outbound
resource "aws_security_group_rule" "group_sgr_egress_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg-group.id}"
}

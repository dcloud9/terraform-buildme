resource "aws_security_group" "sg" {
  description = "vpc-${var.environment}-${var.environment_vpc} VPC Security Group"
  name        = "sgrp-${var.environment}-${var.environment_vpc}"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sg-${var.environment}-${var.environment_vpc}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"

  lifecycle {
    create_before_destroy = true
  }
}

# Allow all outbound
resource "aws_security_group_rule" "sgr_egress_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group" "sg" {
  description = "${var.environment_role} Role Security Group"
  name        = "sgrp-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sg-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}",
    "Owner", "${var.owner}",
    "Region", "${var.region}",
    "Role", "${var.environment_role}"),"${var.tags}",
  )}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elb_sg" {
  description = "ELB ${var.environment_role} Role Security Group"
  name        = "sgrp-elb-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sg-elb-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}",
    "Owner", "${var.owner}",
    "Region", "${var.region}",
    "Role", "${var.environment_role}"),"${var.tags}",
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

resource "aws_security_group_rule" "sgr_elb_egress_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb_sg.id}"
}

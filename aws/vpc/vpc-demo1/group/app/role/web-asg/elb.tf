resource "aws_elb" "elb" {
  lifecycle {
    create_before_destroy = true
  }

  name     = "elb-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}"
  internal = false

  security_groups = [
    "${data.terraform_remote_state.group.group_sg_id}",
    "${aws_security_group.elb_sg.id}",
  ]

  subnets = ["${data.terraform_remote_state.network.public1_subnet_ids}"]

  health_check {
    healthy_threshold   = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    target              = "${var.health_check_target}"
    timeout             = "${var.health_check_timeout}"
    interval            = "${var.health_check_interval}"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"

    #ssl_certificate_id = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-56bf-44e4-9a84-d6c0581bf07d"
  }

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sg-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.environment_group}",
    "Owner", "${var.owner}",
    "Region", "${var.region}",
    "Role", "${var.environment_role}"),"${var.tags}",
  )}"
}

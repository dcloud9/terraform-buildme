resource "aws_instance" "instance" {
  count                = "${length(var.hostname)}"
  ami                  = "${var.ami}"
  iam_instance_profile = "${aws_iam_instance_profile.iamprofile.id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${data.terraform_remote_state.vpc.vpc_key_name}"
  subnet_id            = "${element(data.terraform_remote_state.network.public1_subnet_ids, count.index)}"
  user_data            = "${element(data.template_cloudinit_config.userdata.*.rendered, count.index)}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.vpc.vpc_sg_id}",
    "${data.terraform_remote_state.group.group_sg_id}",
    "${aws_security_group.sg.id}",
  ]

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "${element(var.hostname, count.index)}",
    "Owner", "${var.owner}",
    "Region", "${var.region}",
    "Role", "${var.environment_role}"),"${var.tags}",
  )}"

  associate_public_ip_address = "${var.associate_public_ip_address}"
}

resource "aws_cloudwatch_metric_alarm" "service" {
  count               = "${length(var.hostname)}"
  alarm_name          = "cw-autorecover-${var.environment_role}${count.index + 1}-${var.environment}-${var.environment_vpc}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  alarm_description   = "This metric auto recovers EC2 instances"
  alarm_actions       = ["arn:aws:automate:${var.region}:ec2:recover"]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"
  metric_name         = "StatusCheckFailed_System"

  dimensions {
    InstanceId = "${element(aws_instance.instance.*.id, count.index)}"
  }
}

# Attach EIP
resource "aws_eip" "eip" {
  count    = "${var.use_eip == "yes" ? 1 : 0}"
  instance = "${element(aws_instance.instance.*.id, var.active == "AZ1" ? 0 : 1)}"
  vpc      = true
}

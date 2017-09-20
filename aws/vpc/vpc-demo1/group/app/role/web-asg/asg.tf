resource "aws_launch_configuration" "lc" {
  name_prefix                 = "lc-${var.environment_role}-${var.environment}-${var.environment_vpc}-"
  associate_public_ip_address = "${var.lc_associate_public_ip_address}"
  ebs_optimized               = "${var.lc_ebs_optimized}"
  enable_monitoring           = "${var.lc_enable_monitoring}"
  iam_instance_profile        = "${aws_iam_instance_profile.iamprofile.id}"
  image_id                    = "${var.lc_image_id}"
  instance_type               = "${var.lc_instance_type}"
  key_name                    = "${data.terraform_remote_state.vpc.vpc_key_name}"

  security_groups = [
    "${data.terraform_remote_state.vpc.vpc_sg_id}",
    "${data.terraform_remote_state.group.group_sg_id}",
    "${aws_security_group.sg.id}",
  ]

  user_data = "${data.template_cloudinit_config.userdata.rendered}"

  root_block_device {
    delete_on_termination = "${var.lc_root_delete_on_termination}"
    iops                  = "${var.lc_root_iops}"
    volume_size           = "${var.lc_root_volume_size}"
    volume_type           = "${var.lc_root_volume_type}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "asg-${var.environment_role}-${var.environment}-${var.environment_vpc}"
  desired_capacity          = "${var.asg_desired_capacity}"
  enabled_metrics           = ["${var.asg_enabled_metrics}"]
  force_delete              = false
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  load_balancers            = ["${aws_elb.elb.name}"]
  launch_configuration      = "${aws_launch_configuration.lc.name}"
  max_size                  = "${var.asg_max_size}"
  min_elb_capacity          = "${var.asg_min_elb_capacity}"
  min_size                  = "${var.asg_min_size}"
  placement_group           = "${var.asg_placement_group}"
  protect_from_scale_in     = "${var.asg_protect_from_scale_in}"
  termination_policies      = ["${var.asg_termination_policies}"]
  vpc_zone_identifier       = ["${data.terraform_remote_state.network.private1_subnet_ids}"]
  wait_for_capacity_timeout = "${var.asg_wait_for_capacity_timeout}"
  wait_for_elb_capacity     = "${var.asg_wait_for_elb_capacity}"

  tags = ["${concat(
    list(
      map("key", "BuiltBy", "value", "${var.built_by}", "propagate_at_launch", true),
      map("key", "Environment", "value", "${var.environment}", "propagate_at_launch", true),
      map("key", "Name", "value", "asg-${element(var.hostname, 0)}", "propagate_at_launch", true),
      map("key", "Owner", "value", "${var.owner}", "propagate_at_launch", true),
      map("key", "Region", "value", "${var.region}", "propagate_at_launch", true),
      map("key", "Role", "value", "${var.environment_role}", "propagate_at_launch", true)
    ),
    var.asg_tags)
  }"]


  lifecycle {
    create_before_destroy = true
  }
}

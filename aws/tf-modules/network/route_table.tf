resource "aws_route_table" "rtb" {
  vpc_id = "${var.vpc_id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "rt-${var.subnet_type}-${var.environment}-${var.environment_vpc}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "igw-${var.environment}-${var.environment_vpc}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"

  lifecycle {
    create_before_destroy = true
  }
}

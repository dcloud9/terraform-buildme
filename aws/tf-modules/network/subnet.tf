resource "aws_subnet" "subnet" {
  count             = "${length(var.subnets)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.subnets[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = "${merge(map(
    "BuiltBy", "${var.built_by}",
    "Environment", "${var.environment}",
    "Name", "sn-${var.subnet_type}-${element(split("-", element(var.availability_zones, count.index)), 2)}-${var.environment}-${var.environment_vpc}",
    "Owner", "${var.owner}",
    "Region", "${var.region}"),"${var.tags}"
  )}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

module "public1" {
  source = "../../../tf-modules/network"

  availability_zones = "${var.availability_zones}"
  built_by           = "${var.built_by}"
  environment        = "${var.environment}"
  environment_vpc    = "${var.environment_vpc}"
  subnet_type        = "${var.public1_subnet_type}"
  subnets            = "${var.subnets_public1}"
  region             = "${var.region}"
  vpc_id             = "${data.terraform_remote_state.vpc.vpc_id}"
  tags               = "${var.tags}"
}

module "private1" {
  source = "../../../tf-modules/network"

  availability_zones = "${var.availability_zones}"
  built_by           = "${var.built_by}"
  environment        = "${var.environment}"
  environment_vpc    = "${var.environment_vpc}"
  subnet_type        = "${var.private1_subnet_type}"
  subnets            = "${var.subnets_private1}"
  region             = "${var.region}"
  vpc_id             = "${data.terraform_remote_state.vpc.vpc_id}"
  tags               = "${var.tags}"
}

module "private2" {
  source = "../../../tf-modules/network"

  availability_zones = "${var.availability_zones}"
  built_by           = "${var.built_by}"
  environment        = "${var.environment}"
  environment_vpc    = "${var.environment_vpc}"
  subnet_type        = "${var.private2_subnet_type}"
  subnets            = "${var.subnets_private2}"
  region             = "${var.region}"
  vpc_id             = "${data.terraform_remote_state.vpc.vpc_id}"
  tags               = "${var.tags}"
}

# VPC Endpoint S3
resource "aws_vpc_endpoint" "vpc_endpoint_s3" {
  vpc_id       = "${data.terraform_remote_state.vpc.vpc_id}"
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    "${module.public1.route_table_id}",
    "${module.private1.route_table_id}",
    "${module.private2.route_table_id}",
  ]
}

# Route public subnets to IGW
resource "aws_route" "route_public1_igw" {
  route_table_id         = "${module.public1.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${data.terraform_remote_state.vpc.vpc_igw_id}"
}

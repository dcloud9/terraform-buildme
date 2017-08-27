module "vpc" {
  source = "../../tf-modules/vpc"

  built_by        = "${var.built_by}"
  cidr_block      = "${var.cidr_block}"
  environment     = "${var.environment}"
  environment_vpc = "${var.environment_vpc}"
  region          = "${var.region}"

  tags = "${var.tags}"
}

# Store remote state file to S3. Use 'terraform env/workspace' to decouple state files per env.
terraform {
  backend "s3" {
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3tfstate}"
    key     = "aws/vpc/vpc-${var.environment_vpc}/terraform.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3tfstate}"
    key     = "aws/vpc/vpc-${var.environment_vpc}/network/terraform.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "group" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3tfstate}"
    key     = "aws/vpc/vpc-${var.environment_vpc}/group/${var.environment_group}/terraform.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "group_app" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3tfstate}"
    key     = "aws/vpc/vpc-${var.environment_vpc}/group/app/terraform.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "role_bastion" {
  backend = "s3"

  config {
    region  = "${var.region}"
    bucket  = "${var.s3tfstate}"
    key     = "aws/vpc/vpc-${var.environment_vpc}/group/dmz/role/bastion/terraform.tfstate"
    encrypt = true
  }
}

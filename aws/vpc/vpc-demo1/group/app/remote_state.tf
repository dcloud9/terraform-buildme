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

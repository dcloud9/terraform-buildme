# VPC
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

# Internet Gateway
output "vpc_igw_id" {
  value = "${module.vpc.vpc_igw_id}"
}

# VPC SG
output "vpc_sg_id" {
  value = "${module.vpc.vpc_sg_id}"
}

# VPC KeyPair
output "vpc_key_name" {
  value = "${aws_key_pair.kp.key_name}"
}

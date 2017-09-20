# VPC
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

# Internet Gateway
output "vpc_igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}

# VPC SG
output "vpc_sg_id" {
  value = "${aws_security_group.sg.id}"
}

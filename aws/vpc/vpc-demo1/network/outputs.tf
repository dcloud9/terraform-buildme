# Public subnets
output "public1_subnets" {
  value = "${var.subnets_public1}"
}

# Private subnets
output "private1_subnets" {
  value = "${var.subnets_private1}"
}

output "private2_subnets" {
  value = "${var.subnets_private2}"
}

# VPC S3 Endpoint
output "vpc_endpoint_s3" {
  value = "${aws_vpc_endpoint.vpc_endpoint_s3.id}"
}

# Public Subnet IDs and NACL IDs
output "public1_subnet_ids" {
  value = ["${module.public1.subnet_ids}"]
}

# Private Subnet IDs and NACL IDs
output "private1_subnet_ids" {
  value = ["${module.private1.subnet_ids}"]
}

output "private1_network_acl_id" {
  value = "${module.private1.network_acl_id}"
}

output "private2_subnet_ids" {
  value = ["${module.private2.subnet_ids}"]
}

output "private2_network_acl_id" {
  value = "${module.private2.network_acl_id}"
}

# Public Route Tables IDs
output "public1_route_table_id" {
  value = "${module.public1.route_table_id}"
}

# Private Route Tables IDs
output "private1_route_table_id" {
  value = "${module.private1.route_table_id}"
}

output "private2_route_table_id" {
  value = "${module.private2.route_table_id}"
}

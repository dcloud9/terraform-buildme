variable "availability_zones" {
  type        = "list"
  description = "(Required) The list of availability zones to associate to the subnets (must match subnets list length)"
}

variable "subnet_type" {
  description = "(Required) Type of subnet for naming including its number i.e 'private1', 'public1'"
}

variable "subnets" {
  type        = "list"
  description = "(Required) The list of subnets to create against the route table"
}

variable "vpc_id" {
  description = "(Required) The id of the VPC the route table / subnets are created within"
}

# Tags
variable "built_by" {
  description = "(Required) The id of the person - used for tagging. e.g. jbloggs or jbloggs@email.com"
}

variable "environment" {
  description = "(Required) The name of the environment that the resource belongs to - used for tagging."
}

variable "environment_vpc" {
  description = "(Required) The name of the VPC that the resource belongs to - used for tagging."
}

variable "region" {
  description = "(Required) The region that the resource belongs to - used for tagging."
}

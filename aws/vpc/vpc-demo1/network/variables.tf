variable "s3tfstate" {
  type = "string"
  description = "(Required) The S3 bucket name to store tfstate files"
}

variable "availability_zones" {
  type        = "list"
  description = "(Required) The list of availability zones to associate to the subnets (must match subnets list length)"
}

variable "subnets_public1" {
  type        = "list"
  description = "(Required) The list of subnets to create against the route table"
}

variable "subnets_private1" {
  type        = "list"
  description = "(Required) The list of subnets to create against the route table"
}

variable "subnets_private2" {
  type        = "list"
  description = "(Required) The list of subnets to create against the route table"
}

variable "public1_subnet_type" {
  type        = "string"
  description = "(Required) A descriptive name of the subnet"
}

variable "private1_subnet_type" {
  type        = "string"
  description = "(Required) A descriptive name of the subnet"
}

variable "private2_subnet_type" {
  type        = "string"
  description = "(Required) A descriptive name of the subnet"
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

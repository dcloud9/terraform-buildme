variable "s3tfstate" {
  description = "(Required) The S3 bucket name to store tfstate files"
}

variable "active" {
  description = "(Required) Which availability zone/AZ is active, e.g. AZ1, AZ2"
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

variable "environment_group" {
  description = "(Required) The name of the Group within VPC that the resource belongs to - used for tagging."
}

variable "environment_role" {
  description = "(Required) The Role of the EC2 instance within VPC - used for tagging."
}

variable "region" {
  description = "(Required) The region that the resource belongs to - used for tagging."
}

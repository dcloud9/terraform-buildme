variable "s3tfstate" {
  type = "string"
  description = "(Required) The S3 bucket name to store tfstate files"
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

variable "region" {
  description = "(Required) The region that the resource belongs to - used for tagging."
}

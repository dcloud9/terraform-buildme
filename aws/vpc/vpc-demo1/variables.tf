variable "cidr_block" {
  description = "(Required) The CIDR block for the VPC"
}

variable "public_key" {
  description = "(Required) The contents of the SSH public key. e.g. ssh-rsa AAA..."
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

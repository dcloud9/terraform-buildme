# Required vars
variable "s3tfstate" {
  description = "(Required) The S3 bucket name to store tfstate files"
}

variable "active" {
  description = "(Required) Which availability zone/AZ is active, e.g. AZ1, AZ2"
  default = "AZ1"
}

variable "ami" {
  description = "(Required) The AMI to use for the instance."
}

variable "instance_type" {
  description = "(Required) The type of instance to start"
}

variable "hostname" {
  description = "(Required) Hostname of instance"
  type        = "list"
}

variable "domainname" {
  description = "(Optional) Domain Name. e.g mydomain.io"
  default = "localdomain"
}

variable "use_eip" {
  description = "(Required) Use or do not use EIP"
  default = "no"
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

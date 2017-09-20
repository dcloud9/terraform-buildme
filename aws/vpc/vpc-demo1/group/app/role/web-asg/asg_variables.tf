
variable "lc_image_id" {
  description = "(Required) The EC2 image ID to launch. Example: ami-abcd1234"
}

variable "lc_instance_type" {
  description = "(Required) The size of instance to launch."
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

variable "asg_tags" {
  type = "list"
  description = "(Optional) Additional ASG tags"
  default = []
}

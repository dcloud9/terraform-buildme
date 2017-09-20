variable "enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true."
  default     = true
}

variable "enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults to true."
  default     = true
}

# Tags
variable "owner" {
  description = "(Optional) The owner responsible for managing the resource - used for tagging."
  default     = "Terraform"
}

variable "tags" {
  description = "(Optional) A map of additional tags to associate with the resource."
  type        = "map"
  default     = {}
}

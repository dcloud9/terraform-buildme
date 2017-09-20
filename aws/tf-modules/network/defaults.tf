variable "map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  default     = false
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

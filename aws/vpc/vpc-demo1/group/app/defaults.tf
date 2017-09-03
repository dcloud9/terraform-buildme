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

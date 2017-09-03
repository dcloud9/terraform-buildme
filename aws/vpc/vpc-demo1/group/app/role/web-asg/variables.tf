# Required vars
variable "s3tfstate" {
  description = "(Required) The S3 bucket name to store tfstate files"
}

variable "active" {
  description = "(Required) Which availability zone/AZ is active, e.g. AZ1, AZ2"
  default     = "AZ1"
}

variable "hostname" {
  description = "(Required) Hostname of instance"
  type        = "list"
}

variable "domainname" {
  description = "(Optional) Domain Name. e.g mydomain.io"
  default     = "localdomain"
}

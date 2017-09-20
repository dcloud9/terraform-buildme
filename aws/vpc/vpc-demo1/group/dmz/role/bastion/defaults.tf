variable "associate_public_ip_address" {
  description = "(Optional) Associate a public ip address with an instance in a VPC. Boolean value."
  default     = false
}

variable "availability_zone" {
  description = "(Optional) The AZ to start the instance in."
  default     = ""
}

variable "disable_api_termination" {
  description = "(Optional) If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  default     = true
}

variable "iam_instance_profile" {
  description = "(Optional) The IAM Instance Profile to launch the instance with."
  default     = ""
}

variable "instance_initiated_shutdown_behavior" {
  description = "(Optional) Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instances. See Shutdown Behavior for more information."
  default     = "stop"
}

variable "monitoring" {
  description = "(Optional) If true, the launched EC2 instance will have detailed monitoring enabled. (Available since v0.6.0)"
  default     = true
}

variable "placement_group" {
  description = "(Optional) The Placement Group to start the instance in."
  default     = ""
}

variable "private_ip" {
  description = "(Optional) Private IP address to associate with the instance in a VPC."
  default     = ""
}

variable "source_dest_check" {
  description = "(Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
  default     = true
}

variable "tenancy" {
  description = "(Optional) The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command."
  default     = ""
}

variable "user_data" {
  description = "(Optional) The user data to provide when launching the instance."
  default     = ""
}

variable "userdata_extra_script" {
  description = "(Optional) Additional bootstrap script."
  default     = "# Extra Script"
}

# Root Block Device
variable "root_delete_on_termination" {
  description = "(Optional) Whether the volume should be destroyed on instance termination (Default: true)."
  default     = true
}

variable "root_iops" {
  description = "(Optional) The amount of provisioned IOPS. This must be set with a volume_type of io1."
  default     = ""
}

variable "root_volume_type" {
  description = "(Optional) The type of volume. Can be standard, gp2, or io1. (Default: gp2)."
  default     = "gp2"
}

variable "root_volume_size" {
  description = "(Optional) The size of the volume in gigabytes."
  default     = ""
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

# Launch Configuration
variable "lc_associate_public_ip_address" {
  description = "(Optional) Associate a public ip address with an instance in a VPC."
  default     = false
}

variable "lc_ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  default     = false
}

variable "lc_enable_monitoring" {
  description = "(Optional) Enables/disables detailed monitoring. This is enabled by default."
  default     = true
}

variable "lc_iam_instance_profile" {
  description = "(Optional) The IAM instance profile to associate with launched instances."
  default     = ""
}

variable "lc_key_name" {
  description = "(Optional) The key name that should be used for the instance."
  default     = ""
}

variable "lc_security_groups" {
  description = "(Required) A list of associated security group IDS. Example: [\"sg-abcd1234\",\"sg-bcde2345\",\"sg-cdef3456\"]"
  type        = "list"
  default     = []
}

variable "lc_user_data" {
  description = "(Optional) The user data to provide when launching the instance. Example: \"file(\\\"./userdata.sh\\\")\". Note of the backslash."
  default     = ""
}

variable "lc_root_delete_on_termination" {
  description = "(Optional) Whether the volume should be destroyed on instance termination."
  default     = true
}

variable "lc_root_iops" {
  description = "(Optional) The amount of provisioned IOPS. This must be set with a volume_type of \"io1\"."
  default     = 0
}

variable "lc_root_volume_size" {
  description = "(Optional) The size of the volume in gigabytes. Warning, size must be greater than or equal the size of AMI."
  default     = 0
}

variable "lc_root_volume_type" {
  description = "(Optional) The type of volume. Can be \"standard\", \"gp2\", or \"io1\". (Default: \"gp2\")."
  default     = "gp2"
}

# Auto Scaling Group
variable "asg_desired_capacity" {
  description = "(Optional) The number of Amazon EC2 instances that should be running in the group. Must be greater than or equal to asg_min_size."
  default     = 1
}

variable "asg_enabled_metrics" {
  description = "(Optional) A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances."
  default     = []
}

variable "asg_health_check_grace_period" {
  description = "(Optional, Default: 300) Time (in seconds) after instance comes into service before checking health."
  default     = "300"
}

variable "asg_health_check_type" {
  description = "(Optional) \"EC2\" or \"ELB\". Controls how health checking is done. Use ELB if setting asg_load_balancers."
  default     = "EC2"
}

variable "asg_load_balancers" {
  description = "(Optional) A list of load balancer names to add to the autoscaling group names."
  default     = []
}

variable "asg_max_size" {
  description = "(Optional) The maximum size of the auto scale group."
  default     = 1
}

variable "asg_min_elb_capacity" {
  description = "(Optional) Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation."
  default     = 0
}

variable "asg_min_size" {
  description = "(Optional) The minimum size of the auto scale group."
  default     = 1
}

variable "asg_placement_group" {
  description = "(Optional) The name of the placement group into which you'll launch your instances, if any."
  default     = ""
}

variable "asg_protect_from_scale_in" {
  description = "(Optional) Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

variable "asg_termination_policies" {
  description = "(Optional) A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  default     = ["Default"]
}

variable "asg_subnets" {
  description = "(Required) A list of subnet IDs to launch resources in. Example: [\"subnet-abcd1234\",\"subnet-bcde2345\",\"subnet-cdef3456\"]"
  type        = "list"
  default     = []
}

variable "asg_wait_for_capacity_timeout" {
  description = "(Optional) A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to \"0\" causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}

variable "asg_wait_for_elb_capacity" {
  description = "(Optional) Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. (Takes precedence over min_elb_capacity behavior.)"
  default     = 0
}

# Tags
variable "owner" {
  description = "(Optional) The owner responsible for managing the resource - used for tagging, and defaulted to Terraform."
  default     = "Terraform"
}

variable "tags" {
  description = "(Optional) A map of additional tags to associate with the resource."
  type        = "map"
  default     = {}
}

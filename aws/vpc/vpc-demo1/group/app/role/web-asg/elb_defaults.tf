# Elastic Load Balancer: Base
variable "connection_draining" {
  description = "Boolean to enable connection draining."
  default     = true
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain."
  default     = 400
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing."
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = 60
}

variable "internal" {
  description = "If true, ELB will be an internal ELB."
  default     = true
}

variable "elb_security_groups" {
  description = "(Required) A list of security group IDs to assign to the ELB. Only valid if creating an ELB within a VPC. Example: [\"sg-abcd1234\",\"sg-bcde2345\",\"sg-cdef3456\"]"
  type        = "list"
  default     = []
}

# Elastic Load Balancer: Access Logs
variable "access_logs_interval" {
  description = "The publishing interval in minutes."
  default     = 60
}

# Elastic Load Balancer: Listener
variable "listener_instance_port" {
  description = "(Required) The port on the instance to route to"
  default     = 443
}

variable "listener_instance_protocol" {
  description = "(Required) The protocol to use to the instance. Valid values are HTTP, HTTPS, TCP, or SSL."
  default     = "tcp"
}

variable "listener_lb_port" {
  description = "(Required) The port to listen on for the load balancer"
  default     = 443
}

variable "listener_lb_protocol" {
  description = "(Required) The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL - Use https or ssl only."
  default     = "tcp"
}

variable "listener_ssl_certificate_id" {
  description = "(Optional) The ARN of an SSL certificate you have uploaded to AWS IAM. Only valid when lb_protocol is either HTTPS or SSL."
  default     = ""
}

# Elastic Load Balancer: Health Check
variable "health_check_healthy_threshold" {
  description = "(Required) The number of checks before the instance is declared healthy."
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "(Required) The number of checks before the instance is declared unhealthy."
  default     = 2
}

variable "health_check_timeout" {
  description = "(Required) The length of time before the check times out."
  default     = 3
}

variable "health_check_interval" {
  description = "(Required) The interval between checks."
  default     = 30
}

variable "health_check_target" {
  description = "(Required) The target of the check. Valid pattern is '${PROTOCOL}:${PORT}${PATH}', where PROTOCOL values are: HTTP, HTTPS - PORT and PATH are required; TCP, SSL - PORT is required, PATH is not supported."
  default     = "TCP:80"
}

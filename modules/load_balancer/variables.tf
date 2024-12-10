variable "security_group_id" {
  description = "Security group ID to associate with the load balancer"
  type        = string
}

variable "subnets" {
  description = "List of subnets for the load balancer"
  type        = list(string)
}
variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be deployed"
  type        = string
}

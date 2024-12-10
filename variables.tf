
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "rpjdev"

}
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]  # Update based on your region
}

variable "domain_name" {
  description = "The domain name for the load balancer"
  default     = "rpjdev.xyz"
}

variable "lb_security_group_id" {
  description = "Security group ID for the load balancer"
  default     = "rpj"
}


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-north-1"
}



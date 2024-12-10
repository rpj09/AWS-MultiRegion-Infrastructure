
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  type        = list(string)
  default     = []
}


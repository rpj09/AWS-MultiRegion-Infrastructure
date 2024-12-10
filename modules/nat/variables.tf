variable "azs" {
  description = "The availability zones"
  type        = list(string)
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for subnets"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}


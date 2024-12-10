variable "azs" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "The name of the VPC"
  type        = string
}

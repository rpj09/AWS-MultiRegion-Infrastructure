
variable "public_subnet_ids" {
  description = "The list of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}


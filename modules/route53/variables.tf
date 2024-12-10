variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
}

variable "elb_dns_name" {
  description = "DNS name of the Elastic Load Balancer"
  type        = string
}

variable "elb_zone_id" {
  description = "Zone ID of the Elastic Load Balancer"
  type        = string
}

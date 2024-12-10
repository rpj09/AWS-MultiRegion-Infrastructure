output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# output "elb_dns_name" {
#   description = "DNS name of the load balancer"
#   value       = module.load_balancer.dns_name
# }

output "route53_zone_id" {
  description = "Route 53 Hosted Zone ID"
  value       = module.route53.hosted_zone_id
}

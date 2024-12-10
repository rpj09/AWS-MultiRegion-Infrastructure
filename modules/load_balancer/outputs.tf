output "load_balancer_arn" {
  description = "ARN of the main load balancer"
  value       = aws_lb.main.arn
}

output "zone_id" {
  value = aws_lb.main.zone_id
}

output "dns_name" {
  value = aws_lb.main.dns_name
}


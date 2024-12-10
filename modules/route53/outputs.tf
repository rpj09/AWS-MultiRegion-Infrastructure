output "hosted_zone_id" {
  value = aws_route53_zone.main.id
}

output "route53_record" {
  value = aws_route53_record.www.name
}

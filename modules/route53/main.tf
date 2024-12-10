resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.id
  name    = "www"
  type    = "A"
  alias {
    name                   = var.elb_dns_name
    zone_id                = var.elb_zone_id
    evaluate_target_health = true
  }
}

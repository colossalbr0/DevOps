output "route53_nameservers" {
  value = aws_route53_zone.public_zone.name_servers
}
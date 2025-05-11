resource "aws_route53_zone" "public_zone" {
  name = var.dmz
}


# resource "aws_route53_zone" "private_zone" {
#   name = "ops.clbro.com"
#   vpc {
#     vpc_id = module.networking.main-vpc-id            #make it a private zone
#   }
# }


resource "aws_route53_record" "nginx" {
  zone_id = aws_route53_zone.public_zone.zone_id
  name    = var.sub-domain-name
  type    = "A"
  ttl     = "300"
  records = [
    var.ec2-public-ip
    ]
}
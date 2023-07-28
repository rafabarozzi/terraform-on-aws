data "aws_route53_zone" "selected" {
  name = "rbarozzi.com"
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "uyuni.rbarozzi.com"
  type    = "A"
  ttl     = "60"
  records = aws_instance.ec2_uyuni.public_ip
}
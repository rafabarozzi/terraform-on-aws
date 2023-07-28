#Terraform Output Values

#EC2 Instance Public IP

output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.ec2_uyuni.public_ip
}

#EC2 Instance Public DNS
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.ec2_uyuni.public_dns
}

# output "rds_endpoint" {
#   description = "RDS Endpoint"
#   value = aws_db_instance.uyuni.endpoint
# }
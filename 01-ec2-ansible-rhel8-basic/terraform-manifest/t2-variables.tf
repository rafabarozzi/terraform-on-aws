#AWS Region
variable "aws_region" {
  description = "AWS Region with resource will be created"
  type = string
  default = "us-east-1"
}

#AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "m5.large"
}

#AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "meykey"
}


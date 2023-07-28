#Create Security Group - SSH Traffic
resource "aws_security_group" "sg-ssh" {
  name        = "uyuni-ssh"
  description = "Security Group to allow inbound SSH traffic"

  ingress {
    description      = "Allow Port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    description = "Allow all IPs and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-ssh-uyuni"
  }
}

#Create Security Group - Web Traffic

resource "aws_security_group" "sg-web" {
  name        = "uyuni-web"
  description = "Security Group to allow inbound Web traffic"
#   vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow Port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

    ingress {
    description      = "Allow Port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    description = "Allow all IPs and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-web-uyuni"
  }
}


resource "aws_security_group" "sg-rds" {
  name   = "uyuni-rds"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # this should be your private subnet range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "sg-rds-uyuni"
  }
}

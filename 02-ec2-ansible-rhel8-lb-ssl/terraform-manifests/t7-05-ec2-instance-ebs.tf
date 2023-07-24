resource "aws_ebs_volume" "st1" {
    availability_zone = module.ec2_private.availability_zone[0]
    size = 120
    tags = {
        name = "awxvl"
    }
}

resource "aws_volume_attachment" "ebs" {
    device_name = "/dev/sdb"
    volume_id = aws_ebs_volume.st1.id
    instance_id = module.ec2_private.id[0]
}


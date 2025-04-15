resource "aws_ebs_volume" "jp_ebs" {
  availability_zone = us-east-1b
  size              = var.ebs_size

    tags = sensitive(
    merge(
      var.tags_all,
      {
        Name = var.ebs_name
      }
    )
  )
}

# Attach EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jp_ebs.id
  instance_id = var.instance_id 
}

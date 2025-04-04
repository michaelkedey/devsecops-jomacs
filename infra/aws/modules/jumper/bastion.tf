resource "aws_instance" "project_bastion" {
  instance_type               = "${var.instance_type}" ["project"]
  ami                         = data.aws_ami.latest_ubuntu.id
  subnet_id                   = var.subnet_id
  security_groups             = var.security_groups
  provider                    = aws.project_region
  associate_public_ip_address = var.public_ip
  user_data                   = file("${path.module}/custome_ssh.sh")

  tags = sensitive(
    merge(
      var.tags_all,
      {
        Name = var.names["instance_name"]
      }
    )
  )
  #key exists already in my cloud environment
  #comment the code below to run without key.
  key_name = var.key_name
}


#ami
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  provider    = aws.project_region

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID

}


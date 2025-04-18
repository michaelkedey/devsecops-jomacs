output "instance_id" {
  value = aws_instance.project_instance.id
}

output "ec2_private_ip" {
  value = aws_instance.project_instance.private_ip
}

output "ec2_public_ip" {
  value = aws_instance.project_instance.public_ip
}

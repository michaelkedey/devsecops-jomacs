output "instance_id" {
  value = aws_instance.project_bastion.id
}

output "bastion_public_ip" {
  value = aws_instance.project_bastion.public_ip
}

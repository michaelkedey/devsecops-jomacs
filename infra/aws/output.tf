output "instance_id" {
  value = module.ec2.instance_id
}

output "pb_sn1" {
  value = aws_subnet.project_public_subnet.id
}

output "pr_sn" {
  value = aws_subnet.project_private_subnet.id
}

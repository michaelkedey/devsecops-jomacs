output "pb_sn" {
  value = aws_subnet.project_public_subnet.id
}

output "pb_sn1" {
  value = aws_subnet.project_public_subnet1.id
}

output "pr_sn" {
  value = aws_subnet.project_private_subnet.id
}

output "pr_sn1" {
  value = aws_subnet.project_private_subnet1.id
}

output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

# output "instance_sg" {
#   value = aws_security_group.project_instance_sg.id
# }
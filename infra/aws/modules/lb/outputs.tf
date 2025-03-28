output "lb_sg" {
  value = aws_security_group.project_lb_sg.id
}

output "instance_sg" {
  value = aws_security_group.project_instance_sg.id
}

output "bastion_sg" {
  value = aws_security_group.project_jumper_sg.id
}

output "lb_dns" {
  value = aws_lb.project_lb.dns_name
}
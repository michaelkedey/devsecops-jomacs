output "lb_sg" {
  value = aws_security_group.project_lb_sg.id
}

output "instance_sg" {
  value = aws_security_group.project_instance_sg.id
}

output "elk_sg" {
  value = aws_security_group.project_elk_sg.id
}

output "bastion_sg" {
  value = aws_security_group.project_jumper_sg.id
}

output "lb_dns" {
  value = aws_lb.project_lb.dns_name
}

output "lb_listener_arn" {
  value = aws_lb_listener.project_lb_listener.arn
}
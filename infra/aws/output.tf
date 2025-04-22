output "public_subnet" {
  value = module.vpc.pb_sn
}

output "public_subnet1" {
  value = module.vpc.pb_sn1
}

output "private_subnet" {
  value = module.vpc.pr_sn
}

output "private_subnet1" {
  value = module.vpc.pr_sn1
}

output "vpc" {
  value = module.vpc.vpc_id
}

output "instance_id" {
  value = module.app_server.instance_id
}

output "lb_sg" {
  value = module.loadbalancer.lb_sg
}

output "instance_sg" {
  value = module.loadbalancer.instance_sg
}

output "elk_sg" {
  value = module.loadbalancer.elk_sg
}


output "bastion_sg" {
  value = module.loadbalancer.bastion_sg
}

output "lb_dns" {
  value = module.loadbalancer.lb_dns
}

output "bastion_public_ip" {
  value = module.jumper_server.ec2_public_ip
}

output "ec2_private_ip" {
  value = module.app_server.ec2_private_ip
}

output "elk_private_ip" {
  value = module.elk_server.ec2_private_ip
}

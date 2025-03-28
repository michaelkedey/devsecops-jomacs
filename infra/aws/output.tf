output "public_subnet" {
  value = module.vpc.pb_sn
}

output "public_subnet1" {
  value = module.vpc.pb_sn1
}

output "private_subnet" {
  value = module.vpc.pr_sn
}

output "vpc" {
  value = module.vpc.vpc_id
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}

output "lb_sg" {
  value = module.lb.lb_sg
}

output "instance_sg" {
  value = module.lb.instance_sg
}
output "public_subnet1" {
  value = module.vpc.pb_sn1
}

output "private_subnet" {
  value = module.vpc.pr_sn
}

output "vpc" {
  value = module.vpc.vpc
}

output "instance_id" {
  value = module.ec2.instance_id
}
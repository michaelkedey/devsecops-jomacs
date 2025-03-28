provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  lb_sg  = module.lb.lb_sg
}

module "ec2" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pr_sn
  security_groups = [module.lb.instance_sg]
  iam_user        = var.iam_user
}

module "bastion" {
  source          = "./modules/jumper"
  subnet_id       = module.vpc.pb_sn
  public_ip       = var.public_ip
  key_name        = var.key_name
  security_groups = module.lb.bastion_sg
}

module "lb" {
  source      = "./modules/lb"
  vpc_id      = module.vpc.vpc_id
  instance_id = module.ec2.instance_id
  subnet_ids  = [module.vpc.pb_sn1, module.vpc.pb_sn]
}
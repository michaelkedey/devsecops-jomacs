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
  security_groups = [module.vpc.instance_sg]
  public_ip       = var.public_ip
  key_name        = var.key_name
  iam_user        = var.iam_user
}

module "lb" {
  source      = "./modules/lb"
  vpc_id      = module.vpc.vpc_id
  instance_id = module.ec2.instance_id
}
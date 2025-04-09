provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  lb_sg  = module.lb.lb_sg
}

module "app_server" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pr_sn
  security_groups = [module.lb.instance_sg]
  key_name        = var.key_name
  public_ip       = var.public_ip["no"]
}

module "jumper_server" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pb_sn
  public_ip       = var.public_ip["yes"]
  key_name        = var.key_name
  security_groups = [module.lb.bastion_sg]
}

module "elk_server" {
  source          = "./modules/ec2"
  subnet_id       = module.vpc.pr_sn1
  public_ip       = var.public_ip["no"]
  key_name        = var.key_name
  security_groups = [module.lb.elk_sg]
}

module "lb" {
  source     = "./modules/lb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.pb_sn1, module.vpc.pb_sn]
}

module "app_tg_and_ln_rules" {
  source       = "./modules/tg_and_ln_rules"
  instance_id  = module.app_server.instance_id
  vpc_id       = module.vpc.vpc_id
  listener_arn = module.lb.lb_listener_arn
  tg_name      = var.names["app-tg"]
  ln_rule_name = var.names["app-ln-rule"]
}

module "elk_tg_and_ln_rules" {
  source       = "./modules/tg_and_ln_rules"
  instance_id  = module.elk_server.instance_id
  vpc_id       = module.vpc.vpc_id
  listener_arn = module.lb.lb_listener_arn
  tg_name      = var.names["app-tg"]
  ln_rule_name = var.names["app-ln-rule"]
}
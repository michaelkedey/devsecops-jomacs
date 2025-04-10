provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  lb_sg  = module.lb.lb_sg
}

module "app_server" {
  source          = "./modules/ec2"
  instance_name   = var.names["app_instance"]
  subnet_id       = module.vpc.pr_sn
  security_groups = [module.lb.instance_sg]
  key_name        = var.key_name
  public_ip       = var.public_ip["no"]
  instance_type   = "${var.instance_type}" ["project"]
}

module "jumper_server" {
  source          = "./modules/ec2"
  instance_name   = var.names["jumper_instance"]
  subnet_id       = module.vpc.pb_sn
  public_ip       = var.public_ip["yes"]
  key_name        = var.key_name
  security_groups = [module.lb.bastion_sg]
  instance_type   = "${var.instance_type}" ["project"]
}

module "elk_server" {
  source          = "./modules/ec2"
  instance_name   = var.names["elk_instance"]
  subnet_id       = module.vpc.pr_sn1
  public_ip       = var.public_ip["no"]
  key_name        = var.key_name
  security_groups = [module.lb.elk_sg]
  instance_type   = "${var.instance_type}" ["production"]
}

module "lb" {
  source     = "./modules/lb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.pb_sn1, module.vpc.pb_sn]
}

module "app_tg_and_ln_rules" {
  source                 = "./modules/tg_and_ln_rules"
  instance_id            = module.app_server.instance_id
  vpc_id                 = module.vpc.vpc_id
  listener_arn           = module.lb.lb_listener_arn
  tg_name                = var.names["app-tg-name"]
  ln_rule_name           = var.names["app-ln-rule"]
  listener_rule_priority = var.listener_rule_priority["first"]
  listener_rule_path     = var.app_listener_rule_path
  tg_port                = var.ports["app"]
}

module "elk_tg_and_ln_rules" {
  source                 = "./modules/tg_and_ln_rules"
  instance_id            = module.elk_server.instance_id
  vpc_id                 = module.vpc.vpc_id
  listener_arn           = module.lb.lb_listener_arn
  tg_name                = var.names["elk-tg-name"]
  ln_rule_name           = var.names["elk-ln-rule"]
  listener_rule_priority = var.listener_rule_priority["second"]
  listener_rule_path     = var.elk_listener_rule_path
  tg_port                = var.ports["elk"]
}
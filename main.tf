provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr_block
  azs                  = var.azs
  name       = var.vpc_name
}

module "subnets" {
  source                = "./modules/subnets"
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  azs                   = var.azs
  vpc_id                = module.vpc.vpc_id
  internet_gateway_id   = module.vpc.internet_gateway_id
}


module "bastion" {
  source               = "./modules/bastion"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.subnets.public_subnets
}

module "nat" {
  source             = "./modules/nat"
  public_subnet_ids   = module.subnets.public_subnets 
  vpc_id             = module.vpc.vpc_id
  azs                = var.azs
}



module "load_balancer" {
  source = "./modules/load_balancer"
  subnets = module.subnets.public_subnets
  security_group_id = var.lb_security_group_id
  vpc_id = module.vpc.vpc_id
}

module "route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
  elb_zone_id  = module.load_balancer.zone_id
  elb_dns_name = module.load_balancer.dns_name

}

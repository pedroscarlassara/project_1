terraform {
  required_version = ">= 1.14.2"
}

provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source                      = "./modules/ec2"
  project_public_subnet_1_id  = module.vpc.public_subnet_1
  project_private_subnet_1_id = module.vpc.private_subnet_1
  application_sg_id           = module.security_group.application_sg_id
  bastion_sg_id               = module.security_group.bastion_sg_id
  ec2role_name                = module.iam.ec2role_name
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/vpc"
}

module "load_balancer" {
  source                     = "./modules/load_balancer"
  vpc_id                     = module.vpc.vpc_id
  project_public_subnet_1_id = module.vpc.public_subnet_1
  project_public_subnet_2_id = module.vpc.public_subnet_2
  alb_sg_id                  = module.security_group.alb_sg_id
  application_instance_id    = module.ec2_instance.application_instance_id
}

module "iam" {
  source = "./modules/iam"
  ec2role_name = module.iam.ec2role_name
}

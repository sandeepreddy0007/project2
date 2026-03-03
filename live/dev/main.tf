provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../modules/vpc"

  cidr_block = "10.0.0.0/16"

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
}

module "alb" {
  source = "../modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
}

module "roles" {
  source = "../modules/roles"
}

module "ecs" {
  source = "../modules/ecs"

  cluster_name       = "dev-ecs"
  container_image    = "nginx:latest"
  subnets            = module.vpc.private_subnet_ids
  security_groups    = []
  tg_arn             = module.alb.tg_arn
  execution_role_arn = module.roles.ecs_task_execution_role_arn
}

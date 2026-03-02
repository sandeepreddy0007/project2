provider "aws" {
  region = "ap-south-1"
}

module "ecs_service" {
  source = "../../modules/ecs-service"

  service_name          = var.service_name
  cluster_name          = var.cluster_name
  task_definition       = var.task_definition
  desired_count         = var.desired_count

  private_subnets        = var.private_subnets
  service_security_group = var.service_security_group

  target_group_arn  = var.target_group_arn
  alb_listener_arn  = var.alb_listener_arn

  container_name = var.container_name
  container_port = var.container_port
}

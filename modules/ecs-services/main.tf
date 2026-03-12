resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}



resource "aws_ecs_task_definition" "task" {
  family                   = "nginx-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = var.task_cpu
  memory = var.task_memory

  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = var.container_image

      cpu    = var.container_cpu
      memory = var.container_memory

      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}



resource "aws_ecs_service" "service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [
    aws_ecs_task_definition.task
  ]
}



resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "ecs-scale-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 50

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}



resource "aws_db_instance" "rds" {

  identifier = "ecs-rds"

  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"

  instance_class = "db.t3.micro"

  username = var.db_username
  password = var.db_password

  skip_final_snapshot = true

  db_subnet_group_name = var.db_subnet_group
  vpc_security_group_ids = var.db_security_groups
}


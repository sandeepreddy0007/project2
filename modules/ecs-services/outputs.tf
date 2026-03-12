output "ecs_cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}

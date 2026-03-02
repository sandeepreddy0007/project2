variable "service_name" {}
variable "cluster_name" {}
variable "task_definition" {}
variable "desired_count" { default = 1 }

variable "private_subnets" { type = list(string) }
variable "service_security_group" {}

variable "target_group_arn" {}
variable "alb_listener_arn" {}

variable "container_name" {}
variable "container_port" {}

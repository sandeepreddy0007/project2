variable "cluster_name" {}

variable "container_image" {}

variable "execution_role_arn" {}

variable "subnets" {}

variable "security_groups" {}

variable "tg_arn" {}


variable "task_cpu" {
  default = "256"
}

variable "task_memory" {
  default = "512"
}

variable "container_cpu" {
  default = 256
}

variable "container_memory" {
  default = 512
}



variable "db_username" {}

variable "db_password" {}

variable "db_subnet_group" {}

variable "db_security_groups" {}

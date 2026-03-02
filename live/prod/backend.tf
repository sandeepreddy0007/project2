terraform {
  backend "s3" {
    bucket = "my-ecs-state-bucket"
    key    = "prod/ecs-service.tfstate"
    region = "ap-south-1"
  }
}

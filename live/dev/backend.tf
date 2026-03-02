terraform {
  backend "s3" {
    bucket = "my-ecs-state-bucket"
    key    = "dev/ecs-service.tfstate"
    region = "ap-south-1"
  }
}

terraform {
  backend "s3" {
    bucket = "your-prod-bucket"
    key    = "ecs/prod/terraform.tfstate"
    region = "ap-south-1"
  }
}

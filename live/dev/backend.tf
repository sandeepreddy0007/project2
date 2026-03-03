terraform {
  backend "s3" {
    bucket = "your-dev-bucket"
    key    = "ecs/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}


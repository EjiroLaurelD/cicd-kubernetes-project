terraform {
  backend "s3" {
    bucket = "sock-shop-exam"
    region = "us-east-1"
    key = "altexam3/terraform.tfstate"
  }
}


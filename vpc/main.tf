provider "aws" {
  region = var.AWS_REGION
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cyberglitch-terraform-state"
    region         = "us-west-2"
    key            = "terraform/dev/terraform.tfstate"
    dynamodb_table = "terraform_state"
  }
}

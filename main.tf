terraform {
  backend "s3" {
    bucket = "fiap-hackaton-video-bucket"
    key    = "infra-hackaton/terraform.tfstate"
    region = "us-east-1"
  }
}

module "projectinfra" {
  source = "./infra"

  project_name = var.projectname
  region       = var.aws_region
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "projectname" {
  type        = string
  default     = "hackaton"
  description = "Application Name"
}

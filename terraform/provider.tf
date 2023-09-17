provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Name = "integration-argoworkflow"
      tag  = "integration-argoworkflow"
    }
  }
}

terraform {
  required_version = "~> 1.5.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
}

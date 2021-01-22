terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
}

module "kinesis" {
  source  = "app.terraform.io/DatasourceConsulting/kinesis/aws"
  version = "1.0.1"
  # insert required variables here
  AWS_REGION       = var.AWS_REGION
  kinesis_name     = var.kinesis_name
  project_name     = var.project_name
  retention_period = var.retention_period
  shard_count      = var.shard_count
}
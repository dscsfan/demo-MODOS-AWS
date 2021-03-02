module "kinesis" {
  source  = "app.terraform.io/DatasourceConsulting/kinesis/aws"
  version = "1.0.2"
  #insert required variables here
  AWS_REGION       = var.AWS_REGION
  kinesis_name     = var.kinesis_name
  project_name     = var.project_name
  retention_period = var.retention_period
  shard_count      = var.shard_count
}

variable "AWS_REGION" {
  #default = "us-west-1"
}
variable "kinesis_name" {
  description = "Kinesis Stream Name"
}
variable "project_name" {
  description = "Project Name"
}
variable "retention_period" {
  description = "Retention Period"
}
variable "shard_count" {
  description = "Shard Count"
}
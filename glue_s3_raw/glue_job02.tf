resource "aws_cloudwatch_log_group" "glue_log_group_job02" {
  name              = var.glue_log_group_name
  retention_in_days = 14
}

resource "aws_glue_job" "glue_job02" {
  name     = var.glue_job_name
  role_arn = data.aws_iam_role.glue_role.arn
  #role_arn = "arn:aws:iam::994037683618:role/modos-aws-glue-role"

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${data.aws_s3_bucket.s3-curated.bucket}/scripts/${var.glue_job_name}"
  }

  default_arguments = {
    "--TempDir"                          = "s3://s3-modos-aws-raw/temp"
    "--job-bookmark-option"              = "job-bookmark-disable"
    "--job-language"                     = "python"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_log_group_job02.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }
  glue_version = "2.0"
}

data "aws_iam_role" "glue_role" {
  name = var.glue_role_name
}

data "aws_s3_bucket" "s3-curated" {
  bucket = var.s3_curated_bucket_name
}

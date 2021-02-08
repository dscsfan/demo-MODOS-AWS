resource "aws_cloudwatch_log_group" "glue_log_group_job01" {
  name              = var.glue_log_group_job01_name
  retention_in_days = 14
}

resource "aws_glue_job" "glue_job01" {
  name     = var.glue_job01_name
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_bucket.s3-raw.scripts}/load-streaming-data-to-raw-01.py"
  }

  default_arguments = {
    # ... potentially other arguments ...
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_log_group_job01.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }
}

data "aws_iam_role" "glue_role" {
  name = var.glue_role_name
}

data "aws_s3_bucket" "s3-raw" {
  bucket = var.s3_raw_bucket_name
}

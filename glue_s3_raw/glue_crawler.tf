resource "aws_glue_crawler" "example" {
  database_name = var.catalog_db_s3_raw_name
  name          = var.crawler_s3_raw_name
  role          = data.aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.s3-raw.bucket}"
  }
}

data "aws_iam_role" "glue_role" {
  name = var.glue_role_name
}

data "aws_s3_bucket" "s3-raw" {
  bucket = var.s3_raw_bucket_name
}

resource "aws_glue_crawler" "glue_crawler_curated" {
  database_name = var.catalog_db_s3_curated_name
  name          = var.crawler_s3_curated_name
  role          = data.aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.s3-curated.bucket}"
  }
}

data "aws_iam_role" "glue_role" {
  name = var.glue_role_name
}

data "aws_s3_bucket" "s3-curated" {
  bucket = var.s3_curated_bucket_name
}

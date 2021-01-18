resource "aws_s3_bucket" "s3-landing" {
  bucket = var.s3_landing_name
  acl    = "private"
  tags = {
    Project  = var.project_name
    Name = var.s3_landing_name
  }
}
resource "aws_s3_bucket" "s3-raw" {
  bucket = var.s3_raw_name
  acl    = "private"
  tags = {
    Project  = var.project_name
    Name = var.s3_raw_name
  }
}
resource "aws_s3_bucket" "s3-curated" {
  bucket = var.s3_curated_name
  acl    = "private"
  tags = {
    Project  = var.project_name
    Name = var.s3_curated_name
  }
}
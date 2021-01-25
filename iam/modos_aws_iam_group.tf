resource "aws_iam_group" "modos_aws_iam_group" {
  name = var.iam_group_name
}
#temporarily give the full access to the following resources, will change
resource "aws_iam_group_policy_attachment" "ec2-full-access" {
  group      = aws_iam_group.modos_aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_iam_group_policy_attachment" "glue-service-role" {
  group      = aws_iam_group.modos_aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
resource "aws_iam_group_policy_attachment" "s3-full-access" {
  group      = aws_iam_group.modos_aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_group_policy_attachment" "rds-full-access" {
  group      = aws_iam_group.modos_aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
resource "aws_iam_group_policy_attachment" "kinesis-full-access" {
  group      = aws_iam_group.modos_aws_iam_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

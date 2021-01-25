resource "aws_iam_role" "glue" {
  name               = var.glue_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name    = var.glue_role_name
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

#temporarily associate to power user policy for test, will change to a specific policy
resource "aws_iam_role_policy_attachment" "power_user" {
  role       = aws_iam_role.glue.id
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

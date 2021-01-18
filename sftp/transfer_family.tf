resource "aws_transfer_server" "transfer_fmly" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.role-transfer_fmly.arn
  tags = {
    Name    = var.transfer_fmly_name
    Project = var.project_name
  }
}

resource "aws_iam_role" "role-transfer_fmly" {
  name               = "role-transfer_fmly"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy-transfer_fmly" {
  name = "policy-transfer_fmly"
  role = aws_iam_role.role-transfer_fmly.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "AllowFullAccesstoCloudWatchLogs",
          "Effect": "Allow",
          "Action": [
          "logs:*"
          ],
          "Resource": "*"
        },
        {
          "Sid": "AllowFullAccesstoS3",
          "Effect": "Allow",
          "Action": [
              "s3:*"
          ],
          "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_transfer_ssh_key" "ssh-key-sftp-user" {
  server_id = aws_transfer_server.transfer_fmly.id
  user_name = aws_transfer_user.sftp-user-01.user_name
  body      = var.ssh_key_body
}

resource "aws_transfer_user" "sftp-user-01" {
  server_id = aws_transfer_server.transfer_fmly.id
  user_name = var.sftp_user_name
  role      = aws_iam_role.role-transfer_fmly.arn

  tags = {
    Name    = var.sftp_user_name
    Project = var.project_name
  }
}

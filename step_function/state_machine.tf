resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = var.state_machine_name
  role_arn = aws_iam_role.iam_for_sfn.arn

  definition = <<EOF
{
  "Comment": "Glue Job Test",
  "StartAt": "Pass",
  "States": {
    "Pass": {
      "Comment": "A Pass state passes its input to its output, without performing work. Pass states are useful when constructing and debugging state machines.",
      "Type": "Pass",
      "Next": "Start Glue Job to load data from s3 raw to s3 curated"
    },
    "Start Glue Job to load data from s3 raw to s3 curated": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "load-data-raw-to-curated-01"
      },
      "Next": "Start Glue Job to load data from s3 curated to RDS PostgreSQL"
    },
    "Start Glue Job to load data from s3 curated to RDS PostgreSQL": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "load-data-curated-to-rds-01"
      },
      "Next": "Glue job finished"
    },
    "Glue job finished": {
      "Type": "Pass",
      "Result": "",
      "End": true
    }
  }
}
EOF
}

data "aws_iam_role" "iam_for_sfn" {
  name = var.iam_role_name
}

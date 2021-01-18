resource "aws_resourcegroups_group" "resgrp-MODOS-AWS" {
  name = "resgrp-MODOS-AWS"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "Project",
      "Values": ["MODOS-AWS"]
    }
  ]
}
JSON
  }
}

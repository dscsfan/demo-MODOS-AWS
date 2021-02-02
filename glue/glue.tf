data "aws_iam_role" "selected" {
  name = var.glue_role_name
}

resource "aws_glue_catalog_database" "catalog_database" {
  name = var.catalog_db_name
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.catalog_table_name
  database_name = aws_glue_catalog_database.catalog_database.name

  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    parameters = {
      endpointUrl = "https://kinesis.us-west-1.amazonaws.com",
      streamName  = "ks-modos-aws-1",
      typeOfData  = "kinesis"
    }
    columns {
      name = "sensorid"
      type = "string"
    }

    columns {
      name = "currenttemperature"
      type = "string"
    }

    columns {
      name = "status"
      type = "string"
    }
  }
}


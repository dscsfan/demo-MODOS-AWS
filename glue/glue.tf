data "aws_iam_role" "selected" {
  name = var.glue_role_name
}

resource "aws_glue_catalog_database" "catalog_database" {
  name = var.catalog_db_name
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.catalog_table_name
  database_name = aws_glue_catalog_database.catalog_database.name
  parameters = {
    classification = "json"
  }
  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    location      = "ks-modos-aws-1"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters = {
      endpointUrl = "https://kinesis.us-west-1.amazonaws.com"
      streamName  = "ks-modos-aws-1"
      typeOfData  = "kinesis"
    }

    ser_de_info {
      name                  = "my-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "sensorid"
      type = "int"
    }

    columns {
      name = "currenttemperature"
      type = "int"
    }

    columns {
      name = "status"
      type = "string"
    }
  }
}


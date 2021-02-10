module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "3.3.0"

  name          = var.rds_cluster_name #resource name
  database_name = var.database_name  #database name
  username      = var.username       #master db username
  password      = var.password       #master db password

  engine         = "aurora-postgresql"
  engine_version = "11.9"

  vpc_id  = data.aws_vpc.selected.id
  subnets = [data.aws_subnet.snet-pri-1.id, data.aws_subnet.snet-pri-2.id]

  replica_count           = 1
  allowed_security_groups = [data.aws_security_group.sg_pri_1.id]
  allowed_cidr_blocks     = [data.aws_vpc.selected.cidr_block]
  instance_type           = "db.t3.medium"
  storage_encrypted       = true
  apply_immediately       = true
  monitoring_interval     = 15

  db_parameter_group_name         = aws_db_parameter_group.rds-pg-modos-aws.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds-clst-pg-modos-aws.name

  #enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    Project = var.project_name
    Name    = var.database_name
  }
}

resource "aws_db_parameter_group" "rds-pg-modos-aws" {
  name   = "rds-pg-modos-aws"
  family = "aurora-postgresql11"
  description = "RDS db parameter group for modos-aws"
}

resource "aws_rds_cluster_parameter_group" "rds-clst-pg-modos-aws" {
  name        = "rds-clst-pg-modos-aws"
  family      = "aurora-postgresql11"
  description = "RDS cluster parameter group for modos-aws"
}
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "snet-pri-1" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.pri_snet_name_1]
  }
}

data "aws_subnet" "snet-pri-2" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.pri_snet_name_2]
  }
}

data "aws_security_group" "sg_pri_1" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.sg_pri_1]
  }
}
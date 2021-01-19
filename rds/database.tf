module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name = var.database_name

  engine         = "aurora-postgresql"
  engine_version = "9.6.9"

  vpc_id  = data.aws_vpc.selected.id
  subnets = ["${data.aws_subnet.snet-pri-1.id}", "${data.aws_subnet.snet-pri-2.id}"]

  replica_count           = 1
  allowed_security_groups = ["${data.aws_security_group.sg_pri_1.id}"]
  allowed_cidr_blocks     = ["${data.aws_vpc.selected.cidr_block}"]
  instance_type           = "db.t3.medium"
  storage_encrypted       = true
  apply_immediately       = true
  monitoring_interval     = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

data "aws_vpc" "selected" {
  tags {
    Name = var.vpc_name
  }
}

data "aws_subnet" "snet-pri-1" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = var.pri_snet_name_1
  }
}

data "aws_subnet" "snet-pri-2" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name = var.pri_snet_name_2
  }
}

data "aws_security_group" "sg_pri_1" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Name    = var.sg_pri_1
  }
}


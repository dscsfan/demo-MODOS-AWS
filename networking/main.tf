terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
}

module "netwk" {
  source          = "app.terraform.io/DatasourceConsulting/netwk/aws"
  AWS_REGION      = var.AWS_REGION
  azs             = var.azs
  igw_name        = var.igw_name
  pri_snet_cidr_1 = var.pri_snet_cidr_1
  pri_snet_cidr_2 = var.pri_snet_cidr_2
  pri_snet_name_1 = var.pri_snet_name_1
  pri_snet_name_2 = var.pri_snet_name_2
  project_name    = var.project_name
  pub_snet_cidr   = var.pub_snet_cidr
  pub_snet_name   = var.pub_snet_name
  rt_name_pub     = var.rt_name_pub
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  version         = "1.0.0"
}

resource "aws_security_group" "sg_pub_1" {
  name   = "sg_pub_1"
  vpc_id = module.netwk.vpc_id
  
  ingress {
    count = length(var.pub_ingress_rules)
    from_port   = var.pub_ingress_rules[count.index].from_port
    to_port     = var.pub_ingress_rules[count.index].to_port
    protocol    = var.pub_ingress_rules[count.index].protocol
    cidr_blocks = [var.pub_ingress_rules[count.index].cidr_block]
    description = var.pub_ingress_rules[count.index].description
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all"
  }

  tags = {
    Name    = "sg_pub_1"
    Project = var.project_name
  }
}

/*
resource "aws_security_group_rule" "pub_ingress_rules" {
  count = length(var.pub_ingress_rules)

  type              = "ingress"
  from_port         = var.pub_ingress_rules[count.index].from_port
  to_port           = var.pub_ingress_rules[count.index].to_port
  protocol          = var.pub_ingress_rules[count.index].protocol
  cidr_blocks       = [var.pub_ingress_rules[count.index].cidr_block]
  description       = var.pub_ingress_rules[count.index].description
  security_group_id = aws_security_group.sg_pub_1.id
}

resource "aws_security_group_rule" "pub_egress_rules" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow all"
  security_group_id = aws_security_group.sg_pub_1.id
}
*/

resource "aws_security_group" "sg_pri_1" {
  name   = "sg_pri_1"
  vpc_id = module.netwk.vpc_id

  tags = {
    Name    = "sg_pri_1"
    Project = var.project_name
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_pub_1.id]
  }
}


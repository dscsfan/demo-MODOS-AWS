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

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = module.netwk.vpc_id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_list]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
    Project = var.project_name
  }
}
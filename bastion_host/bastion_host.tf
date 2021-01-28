resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = var.instance_type
  # the VPC subnet
  subnet_id = data.aws_subnet.snet-pub-1.id
  # the security group
  vpc_security_group_ids = [data.aws_security_group.sg_pub_1.id]
  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name    = var.instance_name
    Project = var.project_name
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "snet-pub-1" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.pub_snet_name]
  }
}

data "aws_security_group" "sg_pub_1" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = [var.sg_pub_name]
  }
}


variable "AWS_REGION" {
  description = "AWS Region"
  #default = "us-west-1"
}
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  #default = "10.1.0.0/16"
}
variable "pub_snet_cidr" {
  description = "public subnet CIDR Block"
  #default = "10.1.1.0/24"
}
variable "pri_snet_cidr_1" {
  description = "private subnet 1 CIDR block"
  #default = "10.1.2.0/24"
}
variable "pri_snet_cidr_2" {
  description = "private subnet 2 CIDR block"
  #default = "10.1.3.0/24"
}
variable "vpc_name" {
  description = "VPC Name"
  #default = "vpc-modos-aws"
}
variable "pub_snet_name" {
  description = "public subnet name"
  #default = "snet-pub-modos-aws-1"
}
variable "pri_snet_name_1" {
  description = "private subnet 1 name"
  #default = "snet-pri-modos-aws-1"
}
variable "pri_snet_name_2" {
  description = "private subnet 2 name"
  #default = "snet-pri-modos-aws-2"
}
variable "project_name" {
  description = "Project Name"
  #default = "modos-aws"
}
variable "azs" {
  description = "availability zones"
  #default = [ "us-west-1a", "us-west-1c", "us-west-1c"]
}
variable "igw_name" {
  description = "internet gateway name"
  #default = "igw-modos-aws"
}
variable "rt_name_pub" {
  description = "route table name"
  #default = "rt-MODOS-AWS-pub-1"
}
variable "ssh_port" {
  description = "ssh port"
  #default = "22"  
}
variable "ssh_cidr_list" {
  description = "cidr blocks allowed ssh"
  #default = []  
}
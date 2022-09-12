provider "aws" {
    region = "eu-west-3"
}


variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "avail_zone" {}
variable "env_prefix" {}
variable "my_ip" {}
variable "instance_type" {}
variable "key_pair_name" {}
variable "public_key_location" {}

data "aws_subnet" "my-jenkins-subnet" {
  tags = {
    "Name" = "jenkins-subnet-1"
  }
}

data "aws_security_group" "my-jenkins-sg" {
  tags = {
    "Name" = "jenkins-sg"
  }
}


resource "aws_instance" "myapp-server" {
  ami = "ami-0eb375f24fdf647b8"
  instance_type = var.instance_type

  subnet_id = data.aws_subnet.my-jenkins-subnet.id
  vpc_security_group_ids = [data.aws_security_group.my-jenkins-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  key_name = "web-server-key-pair"

# User_data block is executed once, on the first time running the instance

  user_data = file("entry-script.sh")

  tags = {
    Name: "${var.env_prefix}-server"
  }

}
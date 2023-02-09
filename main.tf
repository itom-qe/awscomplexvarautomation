provider "aws" {
  access_key          = "${var.access_key}"
  secret_key          = "${var.secret_key}"
  region              = "${var.region}"
}

resource "aws_vpc" "default" {
	cidr_block = "10.0.0.0/26"
	tags = {
		Name = var.subnetTuple[2]["name"]
	}
}

resource "aws_subnet" "subnetByTFE" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/26"
  tags = {
    environment = var.subnetTuple[2]["env"]
  }
}

resource "aws_network_interface" "nicByTFO" {
  subnet_id = "${aws_subnet.subnetByTFE.id}"
  description = "My NIC"
  tags = {
    Name = var.mapvar["name"]
  }
}

resource "aws_instance" "ec2ByTFOtest" {
  ami           = "${var.ami["ami2"]}"
  instance_type = "${var.instance_type[1]["type2"]}"
  tags = var.objectVar
  #name = var.objectVar["name"]

  network_interface {
    network_interface_id = "${aws_network_interface.nicByTFO.id}"
    device_index         = var.numberType
  }
}

variable "access_key" {}

variable "secret_key" {}

variable "region" {
  type  = string
}

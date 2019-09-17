resource "aws_vpc" "bastion" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "bastion"
  }
}

// create public subnet

resource "aws_subnet" "bastion-public-1" {
  vpc_id                  = "${aws_vpc.bastion.id}"
  availability_zone       = "ap-south-1a"
  cidr_block              = "10.0.128.0/20"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "bastion-public-1"
  }
}

resource "aws_subnet" "bastion-public-2" {
  vpc_id                  = "${aws_vpc.bastion.id}"
  availability_zone       = "ap-south-1b"
  cidr_block              = "10.0.144.0/20"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "bastion-public-2"
  }
}

// create private subnet

resource "aws_subnet" "bastion-private-1" {
  vpc_id                  = "${aws_vpc.bastion.id}"
  cidr_block              = "10.0.0.0/19"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "bastion-private-1"
  }
}

resource "aws_subnet" "bastion-private-2" {
  vpc_id                  = "${aws_vpc.bastion.id}"
  cidr_block              = "10.0.32.0/19"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "bastion-private-2"
  }
}

// crate Internet Gateway
resource "aws_internet_gateway" "bastion-public-igw" {
  vpc_id = "${aws_vpc.bastion.id}"

  tags = {
    Name = "bastion-public-igw"
  }
}

// Create public route 
resource "aws_route_table" "bastion-route-public-1" {
  vpc_id = "${aws_vpc.bastion.id}"

  route {
    cidr_block = "10.0.128.0/0"
    gateway_id = "${aws_internet_gateway.bastion-public-igw.id}"
  }
}

resource "aws_route_table" "bastion-route-public-2" {
  vpc_id = "${aws_vpc.bastion.id}"

  route {
    cidr_block = "10.0.144.0/0"
    gateway_id = "${aws_internet_gateway.bastion-public-igw.id}"
  }
}

// associate subnet to public route table
resource "aws_route_table_association" "bastion-public-route-assoc-1" {
  subnet_id      = "${aws_subnet.bastion-public-1.id}"
  route_table_id = "${aws_route_table.bastion-route-public-1.id}"
}

resource "aws_route_table_association" "bastion-public-route-assoc-2" {
  subnet_id      = "${aws_subnet.bastion-public-2.id}"
  route_table_id = "${aws_route_table.bastion-route-public-2.id}"
}
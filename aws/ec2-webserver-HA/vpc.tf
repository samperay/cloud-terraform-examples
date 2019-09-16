resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main-subnet-public-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "main-subnet-public-1"
  }
}

resource "aws_subnet" "main-subnet-public-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "main-subnet-public-2"
  }
}

resource "aws_internet_gateway" "main-public-igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main-public-igw"
  }
}

resource "aws_route_table" "main-public-route-1" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-public-igw.id}"
  }

  tags = {
    Name = "main-public-route-1"
  }
}

resource "aws_route_table" "main-public-route-2" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-public-igw.id}"
  }

  tags = {
    Name = "main-public-route-2"
  }
}

resource "aws_route_table_association" "public-rt-association-1" {
  subnet_id      = "${aws_subnet.main-subnet-public-1.id}"
  route_table_id = "${aws_route_table.main-public-route-1.id}"
}

resource "aws_route_table_association" "public-rt-association-2" {
  subnet_id      = "${aws_subnet.main-subnet-public-2.id}"
  route_table_id = "${aws_route_table.main-public-route-2.id}"
}

 
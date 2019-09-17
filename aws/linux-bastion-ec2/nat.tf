// Create an elastic IP address for NAT Gateway
resource "aws_eip" "eip-nat" {
  vpc = true
}

// Create a NAT gateway 

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.eip-nat.id}"
  subnet_id     = "${aws_subnet.bastion-public-1.id}"

  tags = {
    Name = "natgw"
  }
}

// Create private route

resource "aws_route_table" "bastion-route-private-gw-1" {
  vpc_id = "${aws_vpc.bastion.id}"

  route {
    cidr_block = "10.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }

  tags = {
    Name = "bastion-route-private-gw-1"
  }
}

resource "aws_route_table" "bastion-route-private-gw-2" {
  vpc_id = "${aws_vpc.bastion.id}"

  route {
    cidr_block = "10.0.32.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }

  tags = {
    Name = "bastion-route-private-gw-2"
  }
}

// associate private route to subnet

resource "aws_route_table_association" "bastion-private-route-assoc-1" {
  subnet_id      = "${aws_subnet.bastion-private-1.id}"
  route_table_id = "${aws_route_table.bastion-route-private-gw-1.id}"
}

resource "aws_route_table_association" "bastion-private-route-assoc-2" {
  subnet_id      = "${aws_subnet.bastion-private-2.id}"
  route_table_id = "${aws_route_table.bastion-route-private-gw-2.id}"
}
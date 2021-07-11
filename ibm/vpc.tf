# Create a VPC
resource "ibm_is_vpc" "testvpc" {
  name = "testvpc"
}

# Create routing table entry for the VPC
resource "ibm_is_vpc_routing_table" "testroutingtable" {
  name = "testroutingtable"
  vpc  = ibm_is_vpc.testvpc.id
}

# Create subnet for us-south region 
resource "ibm_is_subnet" "testsubnet" {
  name            = "testsubnet"
  vpc             = ibm_is_vpc.testvpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
  routing_table   = ibm_is_vpc_routing_table.testroutingtable.routing_table
}

# Create a new security group for testvpc 
resource "ibm_is_security_group" "testsg" {
  name = "test"
  vpc  = ibm_is_vpc.testvpc.id
}

# Create security group rules 
resource "ibm_is_security_group_rule" "testacc_security_group_rule_all" {
    group = ibm_is_security_group.testsg.id
    direction = "inbound"
    remote = "0.0.0.0/0"
    depends_on = [ibm_is_security_group.testsg]
 }

 resource "ibm_is_security_group_rule" "testacc_security_group_rule" {
    group = ibm_is_security_group.testsg.id
    direction = "outbound"
    remote = "0.0.0.0/0"
    depends_on = [ibm_is_security_group_rule.testacc_security_group_rule_all]
 }

# Create EIP
resource "ibm_is_floating_ip" "test-eip" {
  name   = "testing-eip"
  target = ibm_is_instance.testinstance.primary_network_interface[0].id
}
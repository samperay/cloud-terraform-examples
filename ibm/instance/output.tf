# Resource Group Details

output "rg_id" {
  value       = ibm_resource_group.example_rg.id
  description = "rd id: "
}

output "rg_crn" {
  value       = ibm_resource_group.example_rg.crn
  description = "rg crn: "
}

# VPC Details

output "vpc_id" {
  value       = ibm_is_vpc.example_vpc.id
  description = "vpc id: "
}

output "vpc_crn" {
  value       = ibm_is_vpc.example_vpc.crn
  description = "vpc crn: "
}

# Subnet Details

output "subnet_id" {
  value       = ibm_is_subnet.example_subnet.id
  description = "subnet id: "
}

output "subnet_crn" {
  value       = ibm_is_subnet.example_subnet.crn
  description = "subnet crn: "
}

output "subnet_status" {
  value       = ibm_is_subnet.example_subnet.status
  description = "subnet status: "
}

# Instance Details

output "instance_details" {
  value       = ibm_is_instance.tf_testing_instance
  description = "instance details "
}

# Floating IP

output "floating_ip" {
  value       = ibm_is_floating_ip.tf_testing_fip.address
  description = "floating ip: "
}

output "floating_ip_id" {
  value       = ibm_is_floating_ip.tf_testing_fip.id
  description = "floating resource id: "
}

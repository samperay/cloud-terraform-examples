resource "ibm_resource_group" "example_rg" {
  name = var.resource_group_name
  tags = var.common_tags
}

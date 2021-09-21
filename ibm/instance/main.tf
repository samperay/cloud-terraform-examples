# Create a new resource group

resource "ibm_resource_group" "resourceGroup" {
  name = "samerayani_tf_testing"
}

# Create a new vpc

resource "ibm_is_vpc" "samperay-testing" {
  name = "samerayani_tf_testing"
}

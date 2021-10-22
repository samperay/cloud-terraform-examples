# Create a new resource group
resource "ibm_resource_group" "example_rg" {
  name = "tf_testing_rg"
}

# Create a new vpc
resource "ibm_is_vpc" "example_vpc" {
  name           = "tf-testing-vpc"
  resource_group = ibm_resource_group.example_rg.id
}

# # Create subnet
resource "ibm_is_subnet" "example_subnet" {
  name            = "tf-testing-subnet"
  vpc             = ibm_is_vpc.example_vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
  resource_group  = ibm_resource_group.example_rg.id
}

resource "ibm_is_ssh_key" "example_ssh_key" {
  name           = "tf-testing-ssh"
  public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzc9HpMftFl2eXG0frtUyNSjbQLrCRxq+vBeJMxmvPfT5nAsugM8vh1RyYbJp30nhzmbNaUhOVrpNeCBHjqB6Puaa/w2iGyzTZLTmFXGiQUzvKzhlIDEe/7RChz4V/XBGgM+c4zceNtzTkpMA9bVKWkbMgdh/ZR2pCUdSTY9tZjrK37Go4YMhIca0LV0XTb+nX2oYUsB+2qhmjWFvI9NvBgqMbLJWKNyALOzoLnKq57YoKDJFXDOLH33aNUkUmpjy/FO/NlVPR+1IrqeCxMxa2PAJmX8Aq521JUn11VTUZgO1RTYd3nAaVYZkJlhEYN3ZkJ2rAUlKjwKD9TR7rpLlSYuL3VWDYzLVV1dnu0VDFFdiYG70f/v+u//8NFXhmZqpd9hydIh6ylIfEv/Th/gXFehIRJYAg81Ked4M/Oy+V2c6QtUD8D4mUdZzDnavrmxPdxX7EP5BfINwxwF07g1+RM8LZsvg3VX/RKGPc1pq0F1oCeDKRW1EhXyRAdKVVJWk= sunilamperayani@Sunils-MacBook-Pro.local"
  resource_group = ibm_resource_group.example_rg.id
}

# Create Floating IP
resource "ibm_is_floating_ip" "tf_testing_fip" {
  name           = "tf-testing-fip"
  target         = ibm_is_instance.tf_testing_instance.primary_network_interface[0].id
  resource_group = ibm_resource_group.example_rg.id
}


# Create Instance
resource "ibm_is_instance" "tf_testing_instance" {
  name           = "tf-testing-instance"
  image          = "r006-13938c0a-89e4-4370-b59b-55cd1402562d"
  profile        = "bx2-2x8"
  resource_group = ibm_resource_group.example_rg.id


  primary_network_interface {
    subnet               = ibm_is_subnet.example_subnet.id
    primary_ipv4_address = "10.240.0.6"
    allow_ip_spoofing    = true
  }

  network_interfaces {
    name              = "eth1"
    subnet            = ibm_is_subnet.example_subnet.id
    allow_ip_spoofing = false
  }

  vpc  = ibm_is_vpc.example_vpc.id
  zone = "us-south-1"
  keys = [ibm_is_ssh_key.example_ssh_key.id]

  //User can configure timeouts
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

# Create an SSH key 
resource "ibm_is_ssh_key" "testsshkey" {
  name       = "testsshkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtCa4NtxeBgNH+JXHaD/khBHWcGaXZBkWjE320CIWm5mOyiwxhWO2JuWIYbtDAl2pRo7zCXJQrR+MkYmxaaISsVzQ3u2LOFdA+Zn2/KrcyMGgYdBBweFltSfSTm2Ya4xfI4ZP6FEo4p894DpKKCv4pIHU6inHAAB3GsMer94EOHoGas8lbeA45JD8iPBKdT92z8cg3/Ga8LBDt2JUZz9BTor/qsVJDHcLSk2OwVvgOskwVQpnTUonu8juqjpTHkTnSHa51H3brG91FizUXJUaOQVIJe51Mgo6rUWiD2fGhxsaGluRb3qB826t82wT9xr4GkxqPKNkIikeaAcJNlMVYUNBUJ1G54tKHM4iMKNGxFXtRvpLJ/LbvAOEMdDAAsuKRm0jiA8GDaJ6Wi4oKrSNUXeceY0Ky8VkIoPMbfVfCRATsleFu0l55cQR9SfZOcDHIiTesmaM4VxNs/F+k7Z+yq85Um7WDVMkOhb75NLpOtdxd167T/Jh7tA288PhEoj8= samperay@DESKTOP-FFT494D"
}

# Create an instance 
resource "ibm_is_instance" "testinstance" {
  name = "testinstance1"
  image      = "r006-13938c0a-89e4-4370-b59b-55cd1402562d"
  profile    = "cx2-2x4"
  vpc        = ibm_is_vpc.testvpc.id
  zone       = "us-south-1"
  keys       = [ibm_is_ssh_key.testsshkey.id]
  depends_on = [ibm_is_security_group_rule.testacc_security_group_rule_all]

  primary_network_interface {
    subnet = ibm_is_subnet.testsubnet.id
  }
}
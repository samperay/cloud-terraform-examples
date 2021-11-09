# Create Instance
resource "ibm_is_instance" "tf_testing_instance" {
  name           = "tf-testing-instance"
  image          = "r006-13938c0a-89e4-4370-b59b-55cd1402562d"
  profile        = "bx2-2x8"

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

terraform {
  source = "git::https://github.com/samperay/ec2qa.git?ref=v0.0.2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "example-${local.env}"
  ami_id="ami-09d95fab7fff3776c"
  inst_type="t2.nano"
  inst_counts="1"
}

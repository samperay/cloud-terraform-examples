# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "cisdemo"
  aws_account_id = "072793729805"
  aws_profile    = "default"
}

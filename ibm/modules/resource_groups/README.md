# Creating resource groups

This module creates new resource groups.

There are 3 ways of writing this up ..
1. hardcode vars in the code
2. create a new vars file and use `default`

If you need to define values from the CLI, then
```
export TF_VAR_<vars_name>=<value>
terraform plan
terraform apply
```

3. create a new file `terraform.tfvars` which takes the values by default.

Note: Incase you create a file `create_rg.tfvars` then you need to explicitly define them.

```
terraform plan --var-file=create_rg.tfvars
terraform apply --var-file=create_rg.tfvars
```

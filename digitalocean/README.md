# DigitalOcean

This would contain terraform code for Digital Ocean cloud provider.

# Execution

Create a file called **terraform.tfvars** which includes the DO_TOKENS for creating and accessing the clouds.

```
token = "your token"
pvt_key = "C:/Users/username/private_key"
```

You can add the values from **vars.tf** to **terraform.tfvars** incase you require for some environments.

```
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

folder contains all the AWS Infrastructure required for infrastructure to build using terraform code. 
code resides in each folder follwing the usecase. 

# Execution

create *terraform.tfvars* with your AWS *AWS_ACCESS_KEY= " "* and ** AWS_SECRET_KEY=" "* in this folder. 
create a pair of SSH key using *ssh-keygen -f mykey* 

finally, 

```
terraform init
terraform plan 
terraform apply
```

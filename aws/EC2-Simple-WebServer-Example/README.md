**Linux Bastion**
This would typically create a simple web server with an Amazon AMI. 
Instance are being created with default VPC and created with a security group with SSH and HTTP allowed. 

You have an ouput instance where you can copy paste the IP to browser to check if its been working as expected !

**Execute ?**
create *terraform.tfvars* with your AWS *AWS_ACCESS_KEY= " "* and ** AWS_SECRET_KEY=" "* in this folder
create a pair of SSH key using *ssh-keygen -f mykey* 

finally, 

```
terraform init
terraform plan 
terraform apply
``
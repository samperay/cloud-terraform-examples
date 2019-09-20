**Jenkins**

The terraform code will create an EC2 instance, which is by default installed with latest jenkins which is installed in new EBS volume. (/var/lib/jenkins) for persistant usage of disk space with 20GB
You are provided with an IP of Jenkins instance and you can paste in browser to configure plugins and start your CICD process. 

 **Description:**

Vairables are defied in *variables.tf*, custom vpc has been created with public subnet to access the instance and are defined in *vpc.tf*
*securitygroup.tf* has been opened with *ingress* rules for SSH, HTTP on port 80 and 8080 while allowing all outbound traffic. 
keypair has to be created with *ssh-keygen -f mykey* in order to access the instance. 
tempales are created in order to install with latest jenkins package in *scripts/jenkins-init.sh*

Though its not in HA, you can use this code for temp provising for development/testing in CI/CD proocess.

**Execute ?**
create *terraform.tfvars* with your AWS *AWS_ACCESS_KEY= " "* and ** AWS_SECRET_KEY=" "* in this folder
create a pair of SSH key using *ssh-keygen -f mykey* 

finally, 

```
terraform init
terraform plan 
terraform apply
```
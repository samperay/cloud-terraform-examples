**Custom Cloud Metrics**
This would typically create a simple web server with an Amazon AMI, howeber you would be adding a script which installs custom cloud metrics 
for RAM usage. 

It would typically takes around 300 seconds (5 Minutes) to display.

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
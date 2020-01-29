# Terraform Jenkins

Create a Jenkins Free Style Project.
Provide your SCM repository
Execute below using shell 

```
packer build packer.json| tee /tmp/amiid.txt
AMI_ID=`tail -1 amiid.txt  | awk -F":" '{print $2}' | tr -d '[:blank:]'`
echo 'variable "APP_INSTANCE_AMI" { default = "'${AMI_ID}'" }' > amivar.tf
aws s3 cp amivar.tf s3://terraform-state-ami-packer/amivar.tf
```

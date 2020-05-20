# Summary

Simple EC2 Creation for learning examples on terraform code.

Created an empty ENV variables for aws_access_key and aws_secret_key and I have chosen "ap-south-1" as the default AWS region. 

You can provide your reference to AWS credentials by exporting so that you never hardcode the values..

## For bash shells
$ export TF_VAR_aws_access_key=”YOUR_ACCESS_KEY”
$ export TF_VAR_aws_secret_key=”YOUR_SECRET_KEY”

## For Windows Command Prompt
C:\> set TF_VAR_aws_access_key “YOUR_ACCESS_KEY”
C:\> set TF_VAR_aws_secret_key “YOUR_SECRET_KEY”

```
terraform init
terraform plan
terraform apply
```

# map for lookup table 

Define map for AMI lookup so that you dont have to change any code for instance creations .. 
you can override variables from CLI

Make sure you get the right AMI using lookup function .. 
```
ami = "${lookup(var.amiid, var.aws_region)}"
```

From CLI, you can change the region for your infra to provisioned without changing the code..
```
terraform plan -var aws_region=us-west-1
```
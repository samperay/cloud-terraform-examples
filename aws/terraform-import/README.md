# terraform import 

ec2 machine was already created manually, as part of some testing purpose.. we shall try to import using terraform form so as to create a state file

write the below code manually in *ec2.tf* and import resource using the terraform. Once successful import, you would be created with an *terraform.tfstate* file from which this instance can be modified using the terraform. 

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "bastion" {
  ami                    = "ami-xxxxxx"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ "vpc-xxxxx" ]
  key_name               = "bastion"
  subnet_id              = "subnet-xxxxxx"

  tags = {
    Name = "bastion"
  }
}
```

import using terraform 

```
terraform import aws_instance.bastion i-xxxxxxxxxx
```

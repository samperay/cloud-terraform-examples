# Summary

## Resource Dependencies

Terraform makes managing resource dependencies fairly easy. In fact, most of the time you need not worry about the order in which resources are reated. Terraform builds a dependency graph when it is executed, which determines which resources are dependent on others and which are not. Terraform is able to parallelize operations based upon this dependency graph, thereby being very efficient at creating resources. Terraform supports both implicit and explicit dependencies

## Implict Dependency 

you would want to create a instance in an new VPC or subnet, so you would reference in the aws_instance resource, in which terraform would understand itself and would first create the dependent resources before it creates an instance. 

e.g subnet_id = "${ aws_default_subnet.default_subnet.id }"

## Explict Dependency
There are some dependencies that Terraform may not be aware of. For instance there could be application dependencies on a particular resource that are defined at the application level, not at the infrastructure level. An example of this would be a boot strap script that runs on a compute resource that pulls down software from object storage. In this scenario we would want to ensure that the S3 object storage bucket was created first before the compute instance booted.




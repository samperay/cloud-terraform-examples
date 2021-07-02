# Terraform Up & Running

Writing infrastructure as a code, by **Yevgeniy Brikman**

- chap02  
  # Getting started with Terraform

  - one webserver
    [x] Creating single webserver using ubuntu image.
    [x] Updating the SG groups.
    [x] Update above code using the vars.tf
    [x] Create outputs

  - cluster of servers
    [x] Creating the terraform pre-requsites.
    [x] Create launch configurations. 
    [x] Get details from the VPC which requires for ASG for HA(default).
    [x] Create autoscaling group that refers to launch configurations. 
    [x] Create security group for EC2 in the launch configurations.
    [x] Create Load Balancer.
    [x] Create security groups for the Load Balancer.
    [x] Create listeners.
    [x] Create target groups.
    [x] Create listener rules.
    
- chap04 
  # Create re-usable infrastructure using terraform modules

  create **module** as the main directory, which means there is no code that runs from there. i.e there are no provider module to be there. **modules/services/webserver-cluster** 

  create another directory **stage** and **prod** and we could create cluster using the above module. no need to re-write again the same code. 

  we created **vars.tf** from the base folder and we can customize the values from the prod or stage environment. 

- chap05 
  # Terraform tips and tricks

  - count 
  - for_each
  - using expressions

- chap06 
  # production grade terraform 

  - seperate the cluster by writing seperate modules. 
  - create **examples** folder and test your modules. 

- chap07 
  # testing the terraform code

  
  
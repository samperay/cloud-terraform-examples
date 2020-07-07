# Study Guide - Terraform Associate Certification

Important points to be covered for the exam.
https://learn.hashicorp.com/terraform/certification/terraform-associate-study-guide

We would go through some of the important points as we read through above study guide in theory.

## TOC

### Learn about IaC
- IaC makes it easy to provision and apply infrastructure configurations, saving time. It standardizes workflows across different infrastructure providers (e.g., VMware, AWS, Azure, GCP, etc.) by using a common syntax across all of them.
- **Makes infra more reliable** IaC makes changes idempotent, consistent, repeatable, and predictable.
- With IaC, we can test the code and review the results before the code is applied to our target environments
- Since code is checked into version control systems such as GitHub, GitLab, BitBucket, etc., it is possible to review how the infrastructure evolves over time.
- **Makes infra more manageable** IaC provides benefits that enable mutation, when necessary
Use cases:
 **Heroku App Setup**
 **Multi-Tier Applications**
 **Self-Service Clusters**
 **Software Demos**
 **Disposable Environments**
 **Software Defined Networking**
 **Resource Schedulers**
 **Multi-Cloud Deployment**: Terraform is cloud-agnostic and allows a single configuration to be used to manage multiple providers, and to even handle cross-cloud dependencies. This simplifies management and orchestration, helping operators build large-scale multi-cloud infrastructures.

### Manage infrastructure
https://github.com/terraform-providers/terraform-provider-aws


### Master the workflow
### Learn more subcommands
### Use and create modules
### Read and write configuration
### Manage state
### Debug in Terraform
### Understand Terraform Cloud and Enterprise
Terraform Cloud supports the following VCS providers:
 - GitHub
 - GitHub.com (OAuth)
 - GitHub Enterprise
 - GitLab.com
 - GitLab EE and CE
 - Bitbucket Cloud
 - Bitbucket Server
 - Azure DevOps Server
 - Azure DevOps Services

### More Info

**Terraform language**
Terraform is not a configuration management tool  
Terraform is a declarative language  
Terraform supports a syntax that is JSON compatible  
Terraform is primarily designed on immutable infrastructure principles  

**Terraform string**
https://www.terraform.io/docs/configuration/types.html
 primitive type is a simple type that isn't made from any other types.
 - string
 - number
 - bool

**Complex types**
  **Collection Types**
  A collection type allows multiple values of one other type to be grouped together as a single value. The type of value within a collection is called its element type.
  - list
  - map
  - set
  **Structural types**
  A structural type allows multiple values of several distinct types to be grouped together as a single value.
  - object
  - tuplet

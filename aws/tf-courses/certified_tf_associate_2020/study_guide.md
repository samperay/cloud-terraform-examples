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

*terraform init* Running this command will download and initialize any providers that are not already initialized and are installed in the current working directory.
Note: terraform init cannot automatically download providers that are not distributed by HashiCorp

To upgrade to latest version of all terraform modules ```terraform init -upgrade```
you can also use provider constraints using "version" within a provider block but that declares a new provider configuration that may cause problems particularly when writing shared modules. Hence recommended using "required_providers"

To defined multiple providers you can use "alias", all the plugins would be installed in below location
```
windows 	%APPDATA%\terraform.d\plugins
Other systems ~/.terraform.d/plugins
```
OS which are supported by terraform,
```
darwin
freebsd
linux
openbsd
solaris
windows
```
**purpose of terraform state**
Mapping to the Real World: When you have a resource resource "aws_instance" "foo" in your configuration, Terraform uses this map to know that instance i-abcd1234 is represented by that resource

Metadata: track resource dependencies.

Performance: When running a terraform plan, Terraform must know the current state of resources in order to effectively determine the changes that it needs to make to reach your desired configuration

Syncing: Terraform can use remote locking as a measure to avoid two or more different users accidentally running Terraform at the same time, and thus ensure that each Terraform run begins with the most recent updated state

**terraform settings**
"required_version" setting can be used to constrain which versions of the Terraform CLI can be used with your configuration
```
terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
    }
  }
}
```

**provisioners**

Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.
https://www.terraform.io/docs/provisioners/#provisioners-are-a-last-resort

### Master the workflow
**Core Terraform workflow**
- **write** Author infrastructure as code.
- **plan** Preview changes before applying
- **apply** Provision reproducible infrastructure.

**terraform init**
- Copy a Source Module: By default, terraform init assumes that the working directory already contains a configuration and will attempt to initialize that configuration.
- Backend Initialization: During init, the root configuration directory is consulted for backend configuration and the chosen backend is initialized using the given configuration settings.
- Child Module Installation: During init, the configuration is searched for module blocks, and the source code for referenced modules is retrieved from the locations given in their source arguments.
- Plugin Installation: For providers distributed by HashiCorp, init will automatically download and install plugins if necessary. Plugins can also be manually installed in the user plugins directory, located at ~/.terraform.d/plugins on most operating systems and %APPDATA%\terraform.d\plugins on Windows.

**terraform validate**
Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state. It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types

**terraform plan**
The terraform plan command is used to create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.

By default, plan requires no flags and looks in the current directory for the configuration and state file to refresh.

```
detailed-exitcode - Return a detailed exit code when the command exits. When provided, this argument changes the exit codes and their meanings to provide more granular information about what the resulting plan contains:

0 = Succeeded with empty diff (no changes)
1 = Error
2 = Succeeded with non-empty diff (changes present)

parallelism=n - Limit the number of concurrent operation as Terraform walks the graph. Defaults to 10.

```
Terraform itself does not encrypt the plan file. It is highly recommended to encrypt the plan file if you intend to transfer it or keep it at rest for an extended period of time.

**terraform apply**
The terraform apply command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a terraform plan execution plan.

**terraform destroy**
The terraform destroy command is used to destroy the Terraform-managed infrastructure.

```
The -target flag, instead of affecting "dependencies" will instead also destroy any resources that depend on the target(s) specified. For more information, see the targeting docs from terraform plan.

The behavior of any terraform destroy command can be previewed at any time with an equivalent terraform plan -destroy command.
```

### Learn more subcommands

**terraform force-unlock**
Manually unlock the state for the defined configuration. This command removes the lock on the state for the current configuration. The behavior of this lock is dependent on the backend being used. Local state files cannot be unlocked by another process.

**terraform fmt**
command is used to rewrite Terraform configuration files to a canonical format and style

```
-list=false - Don't list the files containing formatting inconsistencies.
-write=false - Don't overwrite the input files. (This is implied by -check or when the input is STDIN.)
-diff - Display diffs of formatting changes
-check - Check if the input is formatted. Exit status will be 0 if all input is properly formatted and non-zero otherwise.
-recursive - Also process files in subdirectories. By default, only the given directory (or current directory) is processed.
```

**terraform taint**
command manually marks a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
This command will not modify infrastructure, but does modify the state file in order to mark a resource as tainted.

**terraform state**
command is used for advanced state management, Terraform usage becomes more advanced, there are some cases where you may need to modify the terraform.tfstate

**terraform workspaces**
Terraform starts with a single workspace named "default". This workspace is special both because it is the default and also because it cannot ever be deleted

For local state, Terraform stores the workspace states in a directory called terraform.tfstate.d. some teams commit these files to version control, although using a remote backend instead is recommended when there are multiple collaborators

For remote state, the workspaces are stored directly in the configured backend.

**terraform import**
Import will find the existing resource from ID and import it into your Terraform state at the given ADDRESS. ADDRESS must be a valid resource address.

Terraform will attempt to load configuration files that configure the provider being used for import. If no configuration files are present or no configuration for that specific provider is present, Terraform will prompt you for access credentials. You may also specify environmental variables to configure the provider.

The only limitation Terraform has when reading the configuration files is that the import provider configurations must not depend on non-variable inputs.

```
terraform import aws_instance.foo i-abcd1234
terraform import 'aws_instance.baz[0]' i-abcd1234
terraform import 'aws_instance.baz["example"]' i-abcd1234
```

**terraform output**
command is used to extract the value of an output variable from the state file.

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

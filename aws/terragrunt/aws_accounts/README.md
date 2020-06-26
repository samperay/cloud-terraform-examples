# terragrunt

this code would create couple of servers in "qa" and "stage" at once without anyone getting into the workspace and applying terrform maually

terragrunt is used as a wrapper around terraform and it will fork in parallel.

```
terragrunt validate-all
terragrunt plan-all
terragrunt apply-all
```

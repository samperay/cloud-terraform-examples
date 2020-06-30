# Summary

- We can create a new environment provisioning for dev or prod using interpolcation. 

```
vairable = "${var.<defined_var> == "Environmenr" ? true : false }"
```

You can use this for creatiing the count of the EC2 instances after checking "dev" or "prod" environment.
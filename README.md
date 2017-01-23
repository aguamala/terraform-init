terraform-init AWS
===========

Initialize terraform configuration with separate remote states for every AWS service or project.

```
terraform init github.com/aguamala/terraform-init/aws

```

Get modules

```
terraform get

```

Set AWS credentials with IAM FullAccess in "~/aws/.credentials"


```
[user.terraform]
aws_access_key_id = XXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

```


Set terraform profile


```
terraform apply
var.aws_terraform_profile
  Enter a value: user.terraform

```

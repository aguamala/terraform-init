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

Set AWS credentials with IAM FullAccess in "~/aws/.credentials". The profile and username must be the same. For instance, if the username is "user.terraform" the profile must be entered as follow.


```
[user.terraform]
aws_access_key_id = XXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

```

```
terraform apply
var.aws_terraform_profile
  Enter a value: user.terraform

var.aws_terraform_region
  AWS default region

  Enter a value: us-east-1

var.terraform_state_bucket
  Terraform state bucket name

  Enter a value: tf-state-files
```

Enable remote state.

```
sh remote-state-config.sh

```

The purpose of the root tf state file is to control global AWS global services like IAM.


## Create separated tf state file

```
mv tfstate_file_networking_vpc.tf.sample tfstate_file_networking_vpc.tf

```

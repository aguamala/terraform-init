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

Enable remote state. (DEPRECATED)

```
sh remote-state-config.sh
Remote state management enabled
Remote state configured and pulled.
set remote s3 state to terraform.tfstate

```

Remote state.

The module generates tf file backend_config.tf.

Terraform will request to perform the init command again to enable the new backend config. When terraform ask if you want to copy your local tf state file to s3 answer "yes".

The purpose of the root tf state file is to control global AWS global services like IAM.

## Create separated tf state file

```
mv tfstate_file_networking_vpc.tf.sample tfstate_file_networking_vpc.tf

terraform get

terraform apply

```

Enable remote state for separated tfstate file

```
cd networking/vpc/

sh remote-state-config.sh
Remote state management enabled
Remote state configured and pulled.
set remote s3 state to terraform.tfstate

```

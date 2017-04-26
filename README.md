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

Backend configuration.

The module generates tf file backend_config.tf to configure S3 backend to store tf state file.

Terraform will request to perform the init command again to enable the new backend config. When terraform ask if you want to copy your local tf state file to s3 answer "yes".

```
Backend reinitialization required. Please run "terraform init".

terraform init
Downloading modules (if any)...
Get: git::https://github.com/aguamala/terraform-init.git
Get: git::https://github.com/aguamala/terraform-init.git
Initializing the backend...
Do you want to copy state from "local" to "s3"?
  Pre-existing state was found in "local" while migrating to "s3". No existing
  state was found in "s3". Do you want to copy the state from "local" to
  "s3"? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your environment. If you forget, other
commands will detect it and remind you to do so if necessary.

```

The purpose of the root tf state file is to control global AWS global services like IAM.

## Create separated tf state file

```
mv tfstate_file_networking_vpc.tf.sample tfstate_file_networking_vpc.tf

terraform get

terraform apply

```

Enable backend config for separated tfstate file

```
cd networking/vpc/
terraform init

```

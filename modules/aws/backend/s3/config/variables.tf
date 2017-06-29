variable "tfstate_aws_profile" {
  default     = "default"
  description = "Terraform AWS profile"
}

variable "tfstate_aws_region" {
  default     = "us-east-1"
  description = "tf state bucket AWS region"
}

variable "tfstate_bucket" {
  default     = "terraform-state-versioning"
  description = "S3 bucket name to store terraform state file"
}

variable "tfstate_path" {
  default     = ""
  description = "terraform state file S3 key"
}

variable "tfstate_readonlyaccess_users" {
  type    = "list"
  default = []
}

variable "tfstate_fullaccess_users" {
  type    = "list"
  default = []
}

variable "tfstate_readonlyaccess_roles" {
  type    = "list"
  default = []
}

variable "tfstate_fullaccess_roles" {
  type    = "list"
  default = []
}

variable "tfstate_readonlyaccess_groups" {
  type    = "list"
  default = []
}

variable "tfstate_fullaccess_groups" {
  type    = "list"
  default = []
}

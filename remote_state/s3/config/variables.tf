variable "tf_state_aws_profile" {
    default = "default"
    description = "Terraform AWS profile"
}

variable "tf_state_aws_region" {
    default = "us-east-1"
    description = "AWS region"
}

variable "tf_state_bucket" {
    default = "terraform.state.versioning"
    description = "S3 bucket name to store terraform state file"
}

variable "tf_state_name" {
    default = "terraform"
    description = "terraform state file key"
}

variable "tf_state_path" {
    default = ""
    description = "terraform state file S3 key"
}

variable "tf_state_readonlyaccess_users" {
    type = "list"
    default = []
}

variable "tf_state_fullaccess_users" {
    type = "list"
    default = []
}

variable "tf_state_readonlyaccess_roles" {
    type = "list"
    default = []
}

variable "tf_state_fullaccess_roles" {
    type = "list"
    default = []
}

variable "tf_state_readonlyaccess_groups" {
    type = "list"
    default = []
}

variable "tf_state_fullaccess_groups" {
    type = "list"
    default = []
}

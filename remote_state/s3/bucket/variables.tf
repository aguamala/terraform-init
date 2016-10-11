variable "aws_user_bucket_creator" {}

variable "terraform_state_bucket" {
    default = "terraform.state.versioning"
    description = "S3 bucket name to store terraform state file"
}

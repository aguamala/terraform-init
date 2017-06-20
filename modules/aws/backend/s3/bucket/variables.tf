variable "aws_user_bucket_creator" {}

variable "terraform_tfstate_bucket" {
    description = "S3 bucket name to store terraform state file"
}

variable "terraform_tfstate_bucket_aws_region" {
    default = "us-east-1"
    description = "tf state bucket AWS region"
}

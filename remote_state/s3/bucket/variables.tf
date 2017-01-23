variable "aws_user_bucket_creator" {}

variable "terraform_state_bucket" {
    description = "S3 bucket name to store terraform state file"
    default = "tf-state-files-bucket"
}

terraform {
  backend "s3" {
    bucket = "\"${tfstate_bucket}\""
    key    = "\"${tfstate_key}\""
    region = "\"${tfstate_aws_region}\""
    profile = "\"${tfstate_aws_profile}\""
  }
}

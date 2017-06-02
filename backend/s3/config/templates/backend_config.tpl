terraform {
  backend "s3" {
    bucket = "\"${tf_state_bucket}\""
    key    = "\"${tf_state_key}\""
    region = "\"${tf_state_aws_region}\""
    profile = "\"${tf_state_aws_profile}\""
  }
}

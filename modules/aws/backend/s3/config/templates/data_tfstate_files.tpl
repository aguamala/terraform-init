
data "\"terraform_remote_state\"" "\"${tfstate_name}\"" {
    backend = "\"s3\""
    config {
        bucket = "\"${tfstate_bucket}\""
        region = "\"${tfstate_aws_region}\""
        key = "\"${tfstate_key}\""
        profile = "\"${tfstate_aws_profile}\""
    }
}

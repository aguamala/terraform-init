
data "\"terraform_remote_state\"" "\"${tf_state_name}\"" {
    backend = "\"s3\""
    config {
        bucket = "\"${tf_state_bucket}\""
        region = "\"${tf_state_aws_region}\""
        key = "\"${tf_state_key}\""
        profile = "\"${tf_state_aws_profile}\""
    }
}

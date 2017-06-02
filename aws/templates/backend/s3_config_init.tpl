#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "\"${service}_tfstate_backend_config\"" {
    source = "\"github.com/aguamala/terraform-init//backend/s3/config\""

    #remote state backend-config
    tf_state_fullaccess_groups = ["\"\$\{aws_iam_group.${service}_readonlyaccess.name\}\""]
    tf_state_readonlyaccess_groups = ["\"\$\{aws_iam_group.${service}_readonlyaccess.name\}\""]

    tf_state_aws_profile = "\"\$\{var.aws_terraform_profile\}\""
    tf_state_bucket = "\"\$\{module.remote_state_bucket.id\}\""
    tf_state_aws_region = "\"\$\{var.aws_terraform_region\}\""

    tf_state_path = "\"${path}\""
}

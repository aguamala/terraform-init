#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "\"${service}_tfstate_backend_config\"" {
    source = "\"github.com/aguamala/terraform-init//backend/s3/config\""

    #remote state backend-config
    tf_state_fullaccess_groups = ["\"${replace("\"${service}\"", "_", ".")}.fullaccess\""]
    tf_state_readonlyaccess_groups = ["\"${replace("\"${service}\"", "_", ".")}.readonlyaccess\""]

    tf_state_aws_profile = "\"\$\{var.aws_terraform_profile\}\""
    tf_state_bucket = "\"\$\{data.terraform_remote_state.file.module_tfstate_bucket_id\}\""
    tf_state_aws_region = "\"\$\{var.aws_terraform_region\}\""

    tf_state_path = "\"${path}\""
}

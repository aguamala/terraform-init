#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "\"${service}_backend_config\"" {
    source = "\"${modules_path}/modules/aws/backend/s3/config${modules_ref}\""

    tfstate_write_users  = ["\"\$\{var.aws_terraform_profile\}\""]

    #tfstate_write_groups = []

    #tfstate_write_roles  = []

    tfstate_aws_profile = "\"\$\{var.aws_terraform_profile\}\""
    tfstate_bucket = "\"\$\{data.terraform_remote_state.file.module_backend_s3_bucket_id\}\""
    tfstate_aws_region = "\"\$\{var.aws_terraform_region\}\""

    tfstate_path = "\"${path}\""
}

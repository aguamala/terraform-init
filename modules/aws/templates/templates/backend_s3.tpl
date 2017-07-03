#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "\"${service}_backend_config\"" {
    source = "\"../../../modules/aws/backend/s3/config\""

    #tfstate_fullaccess_users      = []
    #tfstate_readonlyaccess_users  = []

    tfstate_fullaccess_groups = ["\"${group_name}.fullaccess\""]
    tfstate_readonlyaccess_groups = ["\"${group_name}.readonlyaccess\""]

    #tfstate_fullaccess_roles      = []
    #tfstate_readonlyaccess_roles  = []

    tfstate_aws_profile = "\"\$\{var.aws_terraform_profile\}\""
    tfstate_bucket = "\"\$\{data.terraform_remote_state.file.module_backend_s3_bucket_id\}\""
    tfstate_aws_region = "\"\$\{var.aws_terraform_region\}\""

    tfstate_path = "\"${path}\""
}

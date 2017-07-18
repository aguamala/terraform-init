#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "IAM_backend_config" {
    source = "/home/gabo/github.com/aguamala/terraform-init//modules/aws/backend/s3/config"

    #tfstate_write_users  = []

    #tfstate_write_groups = []

    #tfstate_write_roles  = []

    tfstate_aws_profile = "${var.aws_terraform_profile}"
    tfstate_bucket = "${data.terraform_remote_state.file.module_backend_s3_bucket_id}"
    tfstate_aws_region = "${var.aws_terraform_region}"

    tfstate_path = "identity/iam/"
}
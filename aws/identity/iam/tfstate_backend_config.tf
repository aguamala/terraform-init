#--------------------------------------------------------------
# config  tfstate file backend
#--------------------------------------------------------------

module "identity_iam_tfstate_backend_config" {
    source = "../../../modules/aws/backend/s3/config"

    #remote state backend-config
    tf_state_fullaccess_groups = ["identity.iam.fullaccess"]
    tf_state_readonlyaccess_groups = ["identity.iam.readonlyaccess"]

    tf_state_aws_profile = "${var.aws_terraform_profile}"
    tf_state_bucket = "${data.terraform_remote_state.file.module_backend_bucket_id}"
    tf_state_aws_region = "${var.aws_terraform_region}"

    tf_state_path = "identity/iam/"
}


#--------------------------------------------------------------
# Init remote state
#--------------------------------------------------------------

module "remote_state_bucket" {
    source = "github.com/aguamala/terraform-init/remote_state/s3//bucket"
    aws_user_bucket_creator = "${var.aws_user_bucket_creator}"
}

variable "aws_user_bucket_creator" {
}

module "root_remote_state_config" {
    source = "github.com/aguamala/terraform-init/remote_state/s3//config"

    #tfstate access
    tf_state_fullaccess_users = ["${var.aws_user_bucket_creator}"]
    tf_state_readonlyaccess_users = ["${var.aws_user_bucket_creator}"]

    #remote state backend-config
    tf_state_aws_profile = "${var.aws_terraform_profile}"
    tf_state_bucket = "${module.remote_state_bucket.id}"
    tf_state_name = "root"

}

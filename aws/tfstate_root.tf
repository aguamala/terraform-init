#--------------------------------------------------------------
# config root remote state
#--------------------------------------------------------------

variable "terraform_state_bucket" {
    description = "Terraform state bucket name"
}

module "remote_state_bucket" {
    source = "github.com/aguamala/terraform-init/remote_state/s3//bucket"
    aws_user_bucket_creator = "${var.aws_terraform_profile}"
    terraform_state_bucket  = "${var.terraform_state_bucket}"
}

module "root_remote_state_config" {
    source = "github.com/aguamala/terraform-init/remote_state/s3//config"

    #tfstate access
    tf_state_fullaccess_users = ["${var.aws_terraform_profile}"]
    tf_state_readonlyaccess_users = ["${var.aws_terraform_profile}"]

    #remote state backend-config
    tf_state_aws_profile = "${var.aws_terraform_profile}"
    tf_state_bucket = "${module.remote_state_bucket.id}"
    #tf_state_name = "root"

}

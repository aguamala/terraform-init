#--------------------------------------------------------------
# config root remote state
#--------------------------------------------------------------

variable "terraform_tfstate_bucket" {
    description = "Terraform state bucket name"
}

output "module_tfstate_bucket_arn" {
  value = "${module.backend_bucket.arn}"
}

output "module_tfstate_bucket_id" {
  value = "${module.backend_bucket.id}"
}

module "backend_bucket" {
    source = "../modules/aws/backend/s3/bucket"
    aws_user_bucket_creator = "${var.aws_terraform_profile}"
    terraform_tfstate_bucket  = "${var.terraform_tfstate_bucket}"
    terraform_tfstate_bucket_aws_region = "${var.aws_terraform_region}"
}

module "backend_config" {
    source = "../modules/aws/backend/s3/config"

    #tfstate access
    tf_state_fullaccess_users = ["${var.aws_terraform_profile}"]
    tf_state_readonlyaccess_users = ["${var.aws_terraform_profile}"]

    #remote state backend-config
    tf_state_aws_profile = "${var.aws_terraform_profile}"
    tf_state_bucket = "${module.backend_bucket.id}"
    tf_state_aws_region = "${var.aws_terraform_region}"

}

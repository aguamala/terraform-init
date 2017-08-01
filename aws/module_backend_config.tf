module "backend_config" {
  source = "github.com/aguamala/terraform-init//modules/aws/backend/s3/config?ref=v0.11"

  #tfstate access
  tfstate_write_users = ["${var.aws_terraform_profile}"]

  #remote state backend-config
  tfstate_aws_profile = "${var.aws_terraform_profile}"
  tfstate_bucket      = "${module.backend_s3_bucket.id}"
  tfstate_aws_region  = "${var.aws_terraform_region}"
}


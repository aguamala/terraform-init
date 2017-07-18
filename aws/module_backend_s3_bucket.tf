#--------------------------------------------------------------
# terraform backend S3 bucket
#--------------------------------------------------------------

output "module_backend_s3_bucket_arn" {
  value = "${module.backend_s3_bucket.arn}"
}

output "module_backend_s3_bucket_id" {
  value = "${module.backend_s3_bucket.id}"
}

output "module_backend_s3_bucket_readonly_policy_name" {
  value = "${module.backend_s3_bucket.readonly_policy_name}"
}

output "module_backend_s3_bucket_readonly_policy_arn" {
  value = "${module.backend_s3_bucket.readonly_policy_arn}"
}

module "backend_s3_bucket" {
  source                                 = "github.com/aguamala/terraform-init//modules/aws/backend/s3/bucket?ref=v0.7"
  aws_user_bucket_creator                = "${var.aws_terraform_profile}"
  terraform_backend_s3_bucket            = "${var.terraform_backend_s3_bucket}"
  terraform_backend_s3_bucket_aws_region = "${var.aws_terraform_region}"
}


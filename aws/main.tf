#--------------------------------------------------------------
# terraform backend S3 bucket
#--------------------------------------------------------------

variable "terraform_backend_s3_bucket" {
  description = "Terraform state bucket name"
}

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
  source                                 = "../modules/aws/backend/s3/bucket"
  aws_user_bucket_creator                = "${var.aws_terraform_profile}"
  terraform_backend_s3_bucket            = "${var.terraform_backend_s3_bucket}"
  terraform_backend_s3_bucket_aws_region = "${var.aws_terraform_region}"
}

#--------------------------------------------------------------
# Create terraform.tfvars
#--------------------------------------------------------------
resource "null_resource" "terraform_tfvars" {
  provisioner "local-exec" {
    command = "echo \"${data.template_file.terraform_tfvars.rendered}\" > terraform.tfvars"
  }
}

data "template_file" "terraform_tfvars" {
  template = "${file("templates/terraform_tfvars.tpl")}"

  vars {
    terraform_tfvars_region       = "${var.aws_terraform_region}"
    terraform_tfvars_profile      = "${var.aws_terraform_profile}"
    terraform_tfvars_state_bucket = "${module.backend_s3_bucket.id}"
  }
}

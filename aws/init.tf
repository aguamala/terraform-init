#--------------------------------------------------------------
# config root remote state
#--------------------------------------------------------------

variable "terraform_tfstate_bucket" {
    description = "Terraform state bucket name"
}

output "module_tfstate_bucket_arn" {
  value = "${module.tfstate_bucket.arn}"
}

output "module_tfstate_bucket_id" {
  value = "${module.tfstate_bucket.id}"
}

module "tfstate_bucket" {
    source = "github.com/aguamala/terraform-init//backend/s3/bucket"
    aws_user_bucket_creator = "${var.aws_terraform_profile}"
    terraform_tfstate_bucket  = "${var.terraform_tfstate_bucket}"
    terraform_tfstate_bucket_aws_region = "${var.aws_terraform_region}"
}

module "init_backend_config" {
    source = "github.com/aguamala/terraform-init//backend/s3/config"

    #tfstate access
    tf_state_fullaccess_users = ["${var.aws_terraform_profile}"]
    tf_state_readonlyaccess_users = ["${var.aws_terraform_profile}"]

    #remote state backend-config
    tf_state_aws_profile = "${var.aws_terraform_profile}"
    tf_state_bucket = "${module.tfstate_bucket.id}"
    tf_state_aws_region = "${var.aws_terraform_region}"

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
        terraform_tfvars_region   = "${var.aws_terraform_region}"
        terraform_tfvars_profile  = "${var.aws_terraform_profile}"
        terraform_tfvars_state_bucket = "${module.tfstate_bucket.id}"

    }
}

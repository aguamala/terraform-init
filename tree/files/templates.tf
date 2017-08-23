variable "terraform_backend_s3_bucket" {
  description = "Terraform state bucket name"
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
    terraform_tfvars_state_bucket = "${var.terraform_backend_s3_bucket}"
  }
}

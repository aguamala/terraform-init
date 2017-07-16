variable "terraform_backend_s3_bucket" {
  description = "Terraform state bucket name"
}

#--------------------------------------------------------------
# backend s3 bucket
#--------------------------------------------------------------
resource "null_resource" "module_backend_s3_bucket" {
  provisioner "local-exec" {
    command = "echo \"${data.template_file.module_backend_s3_bucket.rendered}\" > module_backend_s3_bucket.tf"
  }
}

data "template_file" "module_backend_s3_bucket" {
  template = "${file("templates/module_backend_s3_bucket.tpl")}"

  vars {
    modules_path     = "${var.modules_path}"
    modules_ref      = "${var.modules_ref}"
  }
}

#--------------------------------------------------------------
# backend config
#--------------------------------------------------------------
resource "null_resource" "module_backend_config" {
  provisioner "local-exec" {
    command = "echo \"${data.template_file.module_backend_config.rendered}\" > module_backend_config.tf"
  }
}

data "template_file" "module_backend_config" {
  template = "${file("templates/module_backend_config.tpl")}"

  vars {
    modules_path     = "${var.modules_path}"
    modules_ref      = "${var.modules_ref}"
  }
}

#--------------------------------------------------------------
# default.tf
#--------------------------------------------------------------
resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "echo \"${data.template_file.default.rendered}\" > default.tf"
  }
}

data "template_file" "default" {
  template = "${file("templates/default.tpl")}"

  vars {
    modules_path     = "${var.modules_path}"
    modules_ref      = "${var.modules_ref}"
  }
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

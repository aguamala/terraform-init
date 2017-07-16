#--------------------------------------------------------------
# backend config default
#--------------------------------------------------------------
resource "null_resource" "service_directory" {
  count = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "mkdir -p ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}"
  }
}

resource "null_resource" "data_tfstate_files_link" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "cd ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && if [ ! -L data_tfstate_files.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf; fi"
  }
}

resource "null_resource" "variables_link" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "cd ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && if [ ! -L variables.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf; fi"
  }
}

resource "null_resource" "provider_link" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "cd ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && if [ ! -L provider.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf; fi"
  }
}

resource "null_resource" "terraform_tfvars_link" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "cd ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && if [ ! -L terraform.tfvars ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars; fi"
  }
}

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend/s3/main.tpl")}"
  count    = "${var.domain == "default" && lookup(var.global_services,var.service, false) ? 1 : 0}"

  vars {
    service    = "${var.service}"
    path       = "${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/"
    group_name = "${replace(var.service, "_", ".")}"
    modules_path     = "${var.modules_path}"
    modules_ref      = "${var.modules_ref}"
  }
}

resource "null_resource" "backend_config" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" && lookup(var.global_services,var.service, false) ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config.rendered}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/module_backend_config_${var.service}.tf"
  }
}

#--------------------------------------------------------------
# backend config domain
#--------------------------------------------------------------
resource "null_resource" "service_directory_domain" {
  count = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "mkdir -p ./${var.domain}/${replace(lookup(var.service_names,var.service,var.service), "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${var.domain}/${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && if [ ! -L data_tfstate_files.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && if [ ! -L variables.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf && if [ ! -L provider.tf ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf && if [ ! -L terraform.tfvars ]; then ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
  }
}

data "template_file" "backend_config_domain" {
  template = "${file("${path.module}/templates/backend/s3/main.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    service = "${var.service}"
    path    = "${var.domain}/${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/"
  }
}

resource "null_resource" "backend_config_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config_domain.rendered}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/module_backend_config_${var.domain}_${var.service}.tf"
  }
}

data "template_file" "service_policy_domain" {
  template = "${file("${path.module}/templates/${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/iam_policy.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    domain = "${var.domain}"
  }
}

resource "null_resource" "service_policy_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.service_policy_domain.rendered}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/${var.domain}_${var.service}_policy.tf"
  }
}

data "template_file" "main_service_domain" {
  template = "${file("${path.module}/templates/${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/main.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    domain = "${var.domain}"
  }
}

resource "null_resource" "main_service_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.main_service_domain.rendered}\" > ./${var.domain}/${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/main.tf"
  }
}

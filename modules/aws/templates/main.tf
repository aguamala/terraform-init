#--------------------------------------------------------------
# backend config default
#--------------------------------------------------------------
data "template_file" "fullaccess_group" {
  count    = "${var.domain == "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.service}_fullaccess"
    group_name    = "${replace(var.service, "_", ".")}.fullaccess"
    policy        = "${lookup(var.fullaccess_policies,var.service,"")}"
  }
}

data "template_file" "readonlyaccess_group" {
  count    = "${var.domain == "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.service}_readonlyaccess"
    group_name    = "${replace(var.service, "_", ".")}.readonlyaccess"
    policy        = "${lookup(var.readonlyaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "fullaccess_group" {
  count      = "${var.domain == "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_group.rendered}\" > ./identity/iam/${var.service}_fullaccess_group.tf"
  }
}

resource "null_resource" "readonlyaccess_group" {
  count      = "${var.domain == "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_group.rendered}\" > ./identity/iam/${var.service}_readonlyaccess.tf"
  }
}

resource "null_resource" "service_directory" {
  count = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "mkdir -p ./${replace(var.service, "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${replace(var.service, "_", "/")} && ln -s ${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
  }
}

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend_s3.tpl")}"
  count    = "${var.domain == "default" ? 1 : 0}"

  vars {
    service    = "${var.service}"
    path       = "${replace(var.service, "_", "/")}/"
    group_name = "${replace(var.service, "_", ".")}"
  }
}

resource "null_resource" "backend_config" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config.rendered}\" > ./${replace(var.service, "_", "/")}/backend_module_config.tf"
  }
}

#--------------------------------------------------------------
# backend config domain
#--------------------------------------------------------------
data "template_file" "fullaccess_group_domain" {
  count    = "${var.domain != "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.domain}_${var.service}_fullaccess"
    group_name    = "${var.domain}.${replace(var.service, "_", ".")}.fullaccess"
    policy        = "${lookup(var.fullaccess_policies,var.service,"")}"
  }
}

data "template_file" "readonlyaccess_group_domain" {
  count    = "${var.domain != "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.domain}_${var.service}_readonlyaccess"
    group_name    = "${var.domain}.${replace(var.service, "_", ".")}.readonlyaccess"
    policy        = "${lookup(var.readonlyaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "fullaccess_group_domain" {
  count      = "${var.domain != "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory_domain"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_group_domain.rendered}\" > ./identity/iam/${var.domain}_${var.service}_fullaccess_group.tf"
  }
}

resource "null_resource" "readonlyaccess_group_domain" {
  count      = "${var.domain != "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory_domain"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_group_domain.rendered}\" > ./identity/iam/${var.domain}_${var.service}_readonlyaccess.tf"
  }
}

resource "null_resource" "service_directory_domain" {
  count = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "mkdir -p ./${var.domain}/${replace(var.service, "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${var.domain}/${replace(var.service, "_", "/")} && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
  }
}

data "template_file" "backend_config_domain" {
  template = "${file("${path.module}/templates/backend_s3.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    service    = "${var.service}"
    path       = "${var.domain}/${replace(var.service, "_", "/")}/"
    group_name = "${var.domain}.${replace(var.service, "_", ".")}"
  }
}

resource "null_resource" "backend_config_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config_domain.rendered}\" > ./${var.domain}/${replace(var.service, "_", "/")}/backend_module_config.tf"
  }
}

data "template_file" "service_policy_domain" {
  template = "${file("${path.module}/templates/${replace(var.service, "_", "/")}/iam_policy.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    domain = "${var.domain}"
  }
}

resource "null_resource" "service_policy_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.service_policy_domain.rendered}\" > ./identity/iam/${var.domain}_${var.service}_policy.tf"
  }
}

data "template_file" "main_service_domain" {
  template = "${file("${path.module}/templates/${replace(var.service, "_", "/")}/main.tpl")}"
  count    = "${var.domain != "default" ? 1 : 0}"

  vars {
    domain = "${var.domain}"
  }
}

resource "null_resource" "main_service_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.main_service_domain.rendered}\" > ./${var.domain}/${replace(var.service, "_", "/")}/main.tf"
  }
}

#--------------------------------------------------------------
# IAM service
#--------------------------------------------------------------
data "template_file" "admin_group" {
  count    = "${var.service == "identity_iam" ? length(var.default_groups) : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.service}_administrator_${var.default_groups[count.index]}"
    group_name    = "${var.default_groups[count.index]}"
    group_policy  = "${lookup(var.default_groups_policies,var.default_groups[count.index],"")}"
  }
}

resource "null_resource" "admin_group" {
  count      = "${var.service == "identity_iam" ? length(var.default_groups) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.admin_group.*.rendered[count.index]}\" > ./identity/iam/group_${var.default_groups[count.index]}.tf"
  }
}

#--------------------------------------------------------------
# backend config default
#--------------------------------------------------------------
data "template_file" "fullaccess_group" {
  count    = "${var.domain == "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.service}_fullaccess"
    group_name    = "${lookup(var.service_names,var.service,"")}FullAccess"
    group_policy  = "${lookup(var.fullaccess_policies,var.service,"")}"
  }
}

data "template_file" "readonlyaccess_group" {
  count    = "${var.domain == "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.service}_readonlyaccess"
    group_name    = "${lookup(var.service_names,var.service,"")}ReadOnlyAccess"
    group_policy  = "${lookup(var.readonlyaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "fullaccess_group" {
  count      = "${var.domain == "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_group.rendered}\" > ./identity/iam/group_${lookup(var.service_names,var.service,"")}FullAccess.tf"
  }
}

resource "null_resource" "readonlyaccess_group" {
  count      = "${var.domain == "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_group.rendered}\" > ./identity/iam/group_${lookup(var.service_names,var.service,"")}ReadOnlyAccess.tf"
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
  count    = "${var.domain == "default" && lookup(var.global_services,var.service, false) ? 1 : 0}"

  vars {
    service                   = "${var.service}"
    path                      = "${replace(var.service, "_", "/")}/"
    group_name                = "${replace(var.service, "_", ".")}"
    group_name_readonlyaccess = "${lookup(var.service_names,var.service,"")}ReadOnlyAccess"
    group_name_fullaccess     = "${lookup(var.service_names,var.service,"")}FullAccess"
  }
}

resource "null_resource" "backend_config" {
  depends_on = ["null_resource.service_directory"]
  count      = "${var.domain == "default" && lookup(var.global_services,var.service, false) ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config.rendered}\" > ./${replace(var.service, "_", "/")}/module_backend_config_${var.service}.tf"
  }
}

#--------------------------------------------------------------
# backend config domain
#--------------------------------------------------------------
data "template_file" "fullaccess_group_domain" {
  count    = "${var.domain != "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.domain}_${var.service}_fullaccess"
    group_name    = "${var.domain}_${lookup(var.service_names,var.service,"")}FullAccess"
    group_policy  = "${lookup(var.fullaccess_policies,var.service,"")}"
  }
}

data "template_file" "readonlyaccess_group_domain" {
  count    = "${var.domain != "default" ? 1 : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.domain}_${var.service}_readonlyaccess"
    group_name    = "${var.domain}_${lookup(var.service_names,var.service,"")}ReadOnlyAccess"
    group_policy  = "${lookup(var.readonlyaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "fullaccess_group_domain" {
  count      = "${var.domain != "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory_domain"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_group_domain.rendered}\" > ./identity/iam/${var.domain}_${lookup(var.service_names,var.service,"")}FullAccess_group.tf"
  }
}

resource "null_resource" "readonlyaccess_group_domain" {
  count      = "${var.domain != "default" ? 1 : 0}"
  depends_on = ["null_resource.service_directory_domain"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_group_domain.rendered}\" > ./identity/iam/${var.domain}_${lookup(var.service_names,var.service,"")}ReadOnlyAccess_group.tf"
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
    service                   = "${var.service}"
    path                      = "${var.domain}/${replace(var.service, "_", "/")}/"
    group_name_readonlyaccess = "${var.domain}_${lookup(var.service_names,var.service,"")}ReadOnlyAccess"
    group_name_fullaccess     = "${var.domain}_${lookup(var.service_names,var.service,"")}FullAccess"
  }
}

resource "null_resource" "backend_config_domain" {
  depends_on = ["null_resource.service_directory_domain"]
  count      = "${var.domain != "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config_domain.rendered}\" > ./${replace(var.service, "_", "/")}/module_backend_config_${var.domain}_${var.service}.tf"
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

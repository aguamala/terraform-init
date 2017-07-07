#--------------------------------------------------------------
# IAM service
#--------------------------------------------------------------
data "template_file" "admin_group" {
  count    = "${var.service == "IAM" ? length(var.default_groups) : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name = "${var.service}_administrator_${var.default_groups[count.index]}"
    group_name    = "${var.default_groups[count.index]}"
    group_policy  = "${lookup(var.default_groups_policies,var.default_groups[count.index],"")}"
  }
}

resource "null_resource" "admin_group" {
  count      = "${var.service == "IAM" ? length(var.default_groups) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.admin_group.*.rendered[count.index]}\" > ./identity/iam/admin_group_${var.default_groups[count.index]}.tf"
  }
}

#--------------------------------------------------------------
# backend config default
#--------------------------------------------------------------
data "template_file" "fullaccess_groups" {
  count    = "${var.service == "IAM" ? length(var.fullaccess_groups) : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name     = "${var.fullaccess_groups[count.index]}_fullaccess"
    group_name        = "${var.fullaccess_groups[count.index]}"
    group_policy      = "${lookup(var.fullaccess_groups_policies,var.fullaccess_groups[count.index],"")}"
    group_description = "${lookup(var.fullaccess_groups_policies_description,var.fullaccess_groups[count.index],"")}"
  }
}

resource "null_resource" "fullaccess_groups" {
  count      = "${var.service == "IAM" ? length(var.fullaccess_groups) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_groups.*.rendered[count.index]}\" > ./identity/iam/fullaccess_group_${var.fullaccess_groups[count.index]}.tf"
  }
}

data "template_file" "readonlyaccess_groups" {
  count    = "${var.service == "IAM" ? length(var.readonlyaccess_groups) : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name     = "${var.readonlyaccess_groups[count.index]}_readonlyaccess"
    group_name        = "${var.readonlyaccess_groups[count.index]}"
    group_policy      = "${lookup(var.readonlyaccess_groups_policies,var.readonlyaccess_groups[count.index],"")}"
    group_description = "${lookup(var.readonlyaccess_groups_policies_description,var.readonlyaccess_groups[count.index],"")}"
  }
}

resource "null_resource" "readonlyaccess_groups" {
  count      = "${var.service == "IAM" ? length(var.readonlyaccess_groups) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_groups.*.rendered[count.index]}\" > ./identity/iam/readonly_group_${var.readonlyaccess_groups[count.index]}.tf"
  }
}

resource "null_resource" "service_directory" {
  count = "${var.domain == "default" ? 1 : 0}"

  provisioner "local-exec" {
    command = "mkdir -p ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && ln -s ${replace(replace(lookup(var.service_names,var.service,var.service), "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ${replace(replace(lookup(var.service_names,var.service,var.service), "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf && ln -s ${replace(replace(lookup(var.service_names,var.service,var.service), "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf && ln -s ${replace(replace(lookup(var.service_names,var.service,var.service), "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
  }
}

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend/s3/main.tpl")}"
  count    = "${var.domain == "default" && lookup(var.global_services,var.service, false) ? 1 : 0}"

  vars {
    service    = "${var.service}"
    path       = "${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/"
    group_name = "${replace(var.service, "_", ".")}"
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
    command = "cd ./${var.domain}/${replace(lookup(var.service_names,var.service,var.service), "_", "/")} && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/variables.tf variables.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/provider.tf provider.tf && ln -s ../${replace(replace(var.service, "/([a-zA-Z]*[0-9]?)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
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
    command = "echo \"${data.template_file.service_policy_domain.rendered}\" > ./identity/iam/${var.domain}_${var.service}_policy.tf"
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

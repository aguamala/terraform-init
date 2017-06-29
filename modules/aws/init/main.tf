data "template_file" "fullaccess_group" {
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.service}_fullaccess"
    group_name    = "${replace(var.service, "_", ".")}.fullaccess"
    policy        = "${lookup(var.fullaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "fullaccess_group" {
  count      = "${var.create_fullaccess_group == "yes" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.fullaccess_group.rendered}\" > ./${replace(var.service, "_", "/")}/${var.service}_fullaccess_group.tf"
  }
}

data "template_file" "readonlyaccess_group" {
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    resource_name = "${var.service}_readonlyaccess"
    group_name    = "${replace(var.service, "_", ".")}.readonlyaccess"
    policy        = "${lookup(var.readonlyaccess_policies,var.service,"")}"
  }
}

resource "null_resource" "readonlyaccess_group" {
  count      = "${var.create_readonlyaccess_group == "yes" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.readonlyaccess_group.rendered}\" > ./${replace(var.service, "_", "/")}/${var.service}_readonlyaccess.tf"
  }
}

resource "null_resource" "service_directory" {
  provisioner "local-exec" {
    command = "mkdir -p ./${replace(var.service, "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${replace(var.service, "_", "/")} && ln -s ${replace(replace(var.service, "/([a-zA-Z]*)/", ".."), "_" , "/")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*)/", ".."), "_" , "/")}/variables.tf variables.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*)/", ".."), "_" , "/")}/provider.tf provider.tf && ln -s ${replace(replace(var.service, "/([a-zA-Z]*)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars"
  }
}

#--------------------------------------------------------------
# backend config
#--------------------------------------------------------------

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend_s3.tpl")}"

  vars {
    service              = "${var.service}"
    path                 = "${replace(var.service, "_", "/")}/"
    fullaccess_user      = "${var.fullaccess_user}"
    readonlyaccess_user  = "${var.readonlyaccess_user}"
    fullaccess_group     = "${replace(var.service, "_", ".")}.fullaccess"
    readonlyaccess_group = "${replace(var.service, "_", ".")}.readonlyaccess"
  }
}

resource "null_resource" "backend_config" {
  depends_on = ["null_resource.service_directory"]

  count = "${var.backend == "s3" ? 1 : 0}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_config.rendered}\" > ./${replace(var.service, "_", "/")}/backend_config.tf"
  }
}

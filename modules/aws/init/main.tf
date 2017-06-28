data "template_file" "group" {
  count    = "${length(var.groups)}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"

  vars {
    group  = "${var.groups[count.index]}"
    policy = "${var.policies[count.index]}"
  }
}

resource "null_resource" "groups" {
  count      = "${length(var.groups)}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.group.*.rendered[count.index]}\" > ./${replace(var.service, "_", "/")}/${var.groups[count.index]}.tf"
  }
}

resource "null_resource" "service_directory" {
  provisioner "local-exec" {
    command = "mkdir -p ./${replace(var.service, "_", "/")}"
  }

  provisioner "local-exec" {
    command = "cd ./${replace(var.service, "_", "/")} && ln -s ${replace(replace(var.service, "_", "/"), "/([a-zA-Z]*)/?/", "..")}/data_tfstate_files.tf data_tfstate_files.tf && ln -s ${replace(replace(var.service, "_", "/"), "/([a-zA-Z]*)/?/", "..")}/variables.tf variables.tf && ln -s ${replace(replace(var.service, "_", "/"), "/([a-zA-Z]*)/?/", "..")}/provider.tf provider.tf && ln -s ${replace(replace(var.service, "_", "/"), "/([a-zA-Z]*)/?/", "..")}/terraform.tfvars terraform.tfvars"
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

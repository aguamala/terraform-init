resource "null_resource" "root_directory" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.init_path}"
  }

  provisioner "local-exec" {
    command = "touch ${var.init_path}/global_data_tfstate_files.tf && touch ${var.init_path}/workspace_data_tfstate_files.tf && touch ${var.init_path}/terraform.tfvars && cp -p ${path.module}/files/provider.tf ${var.init_path}/ && cp -p ${path.module}/files/templates.tf ${var.init_path}/ && cp -p ${path.module}/files/variables.tf ${var.init_path}/"
  }

  provisioner "local-exec" {
    command = "mkdir -p  ${var.init_path}/templates && cp -p ${path.module}/files/*.tpl ${var.init_path}/templates/"
  }
}

data "template_file" "root_backend_config" {
  template = "${file("${path.module}/templates/root_backend_s3_config.tpl")}"

  vars {
    modules_path = "${var.modules_path}"
    modules_ref  = "${var.modules_ref}"
  }
}

resource "null_resource" "root_backend_config" {
  depends_on = ["null_resource.root_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.root_backend_config.rendered}\" > ${var.init_path}/module_backend_config.tf"
  }
}

data "template_file" "backend_s3_bucket" {
  template = "${file("${path.module}/templates/backend_s3_bucket.tpl")}"

  vars {
    modules_path = "${var.modules_path}"
    modules_ref  = "${var.modules_ref}"
  }
}

resource "null_resource" "backend_s3_bucket" {
  depends_on = ["null_resource.root_directory"]

  provisioner "local-exec" {
    command = "echo \"${data.template_file.backend_s3_bucket.rendered}\" > ${var.init_path}/module_backend_s3_bucket.tf"
  }
}

resource "null_resource" "service_directory" {
  depends_on = ["null_resource.root_directory"]
  count      = "${length(var.services)}"

  provisioner "local-exec" {
    command = "mkdir -p ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}"
  }

  provisioner "local-exec" {
    command = "mkdir -p ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}/templates"
  }

  provisioner "local-exec" {
    command = "cp -rap ${path.module}/files/${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}/tpl/*  ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}/templates/"
  }

  provisioner "local-exec" {
    command = "cp -rap ${path.module}/files/${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}/tf/*  ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")}/"
  }
}

data "template_file" "service_backend_config" {
  template = "${file("${path.module}/templates/backend_s3_config.tpl")}"
  count    = "${length(var.global_services)}"

  vars {
    service      = "${var.global_services[count.index]}"
    path         = "${replace(lookup(var.service_names,var.global_services[count.index],var.global_services[count.index]), "_", "/")}/"
    modules_path = "${var.modules_path}"
    modules_ref  = "${var.modules_ref}"
  }
}

resource "null_resource" "service_backend_config" {
  depends_on = ["null_resource.service_directory"]
  count      = "${length(var.global_services)}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.service_backend_config.*.rendered[count.index]}\" > ${var.init_path}${replace(lookup(var.service_names,var.global_services[count.index],var.global_services[count.index]), "_", "/")}/module_backend_config_${var.global_services[count.index]}.tf"
  }
}

resource "null_resource" "service_links" {
  depends_on = ["null_resource.service_directory"]
  count      = "${length(var.services)}"

  provisioner "local-exec" {
    command = "cd ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")} && if [ ! -L global_data_tfstate_files.tf ]; then ln -s ${replace(replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "/([a-zA-Z]*[0-9]*)/", ".."), "_" , "/")}/global_data_tfstate_files.tf global_data_tfstate_files.tf; fi"
  }

  provisioner "local-exec" {
    command = "cd ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")} && if [ ! -L root_variables.tf ]; then ln -s ${replace(replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "/([a-zA-Z]*[0-9]*)/", ".."), "_" , "/")}/variables.tf root_variables.tf; fi"
  }

  provisioner "local-exec" {
    command = "cd ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")} && if [ ! -L provider.tf ]; then ln -s ${replace(replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "/([a-zA-Z]*[0-9]*)/", ".."), "_" , "/")}/provider.tf provider.tf; fi"
  }

  provisioner "local-exec" {
    command = "cd ${var.init_path}${replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "_", "/")} && if [ ! -L terraform.tfvars ]; then ln -s ${replace(replace(lookup(var.service_names,var.services[count.index],var.services[count.index]), "/([a-zA-Z]*[0-9]*)/", ".."), "_" , "/")}/terraform.tfvars terraform.tfvars; fi"
  }
}

data "template_file" "networking_vpc_module" {
  template = "${file("${path.module}/templates/networking_vpc.tpl")}"

  vars {
    modules_path = "${var.modules_path}"
    modules_ref  = "${var.modules_ref}"
  }
}

resource "null_resource" "networking_vpc_module" {
  depends_on = ["null_resource.service_directory"]
  count      = "${length(var.global_services)}"

  provisioner "local-exec" {
    command = "echo \"${data.template_file.networking_vpc_module.rendered}\" > ${var.init_path}networking/vpc/module.tf"
  }
}

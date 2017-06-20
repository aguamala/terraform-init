

data "template_file" "group" {
  count    = "${length(var.groups)}"
  template = "${file("${path.module}/templates/iam_group.tpl")}"
  vars {
    group = "${var.groups[count.index]}"
    policy = "${var.policies[count.index]}"
  }
}

resource "null_resource" "groups" {
    count     = "${length(var.groups)}"
    depends_on = ["null_resource.service_directory"]

    provisioner "local-exec" {
        command = "echo \"${data.template_file.group.*.rendered[count.index]}\" > ./identity/iam/${var.groups[count.index]}.tf"
    }
}

resource "null_resource" "service_directory" {
    provisioner "local-exec" {
        command = "mkdir -p ./identity/iam"
    }

    provisioner "local-exec" {
        command = "cd ./identity/iam && ln -s ../../data_tfstate_files.tf data_tfstate_files.tf && ln -s ../../variables.tf variables.tf && ln -s ../../provider.tf provider.tf && ln -s ../../terraform.tfvars terraform.tfvars"
    }
}

#--------------------------------------------------------------
# backend config
#--------------------------------------------------------------

data "template_file" "backend_config" {
  template = "${file("${path.module}/templates/backend_s3.tpl")}"
  vars {
    service = "identity_iam"
    path = "identity/iam/"
    fullaccess_group = "identity.iam.fullaccess"
    readonlyaccess_group = "identiy.iam.readonlyaccess"
  }
}

resource "null_resource" "backend_config" {
    depends_on = ["null_resource.service_directory"]

    count = "${var.backend == "s3" ? 1 : 0}"

    provisioner "local-exec" {
        command = "echo \"${data.template_file.backend_config.rendered}\" > ./identity/iam/backend_config.tf"
    }
}

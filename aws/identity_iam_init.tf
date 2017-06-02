#LIMTIS
#http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html
#user 10 groups

#--------------------------------------------------------------
# identity iam users, groups and policies
#--------------------------------------------------------------

variable "groups" {
  default = {
    "0" = "identity_iam_fullaccess"
    "1" = "identiy_iam_readonlyaccess"
  }
}

variable "policies" {
  type = "map"
  default = {
    "0"   = "arn:aws:iam::aws:policy/IAMFullAccess"
    "1"   = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  }
}

data "template_file" "iam_group" {
  count    = "${length(var.groups)}"
  template = "${file("templates/iam/groups_init.tpl")}"
  vars {
    group = "${var.groups[count.index]}"
    policy = "${var.policies[count.index]}"
  }
}

resource "null_resource" "iam_groups" {
    count     = "${length(var.groups)}"
    depends_on = ["null_resource.identity_iam_directory"]

    provisioner "local-exec" {
        command = "echo \"${data.template_file.iam_group.*.rendered[count.index]}\" > ./identity/iam/${var.groups[count.index]}.tf"
    }
}

resource "null_resource" "identity_iam_directory" {
    provisioner "local-exec" {
        command = "mkdir -p ./identity/iam"
    }

    provisioner "local-exec" {
        command = "ln -s ../../data_tfstate_files.tf data_tfstate_files.tf"
    }
}

#--------------------------------------------------------------
# identity iam backend config
#--------------------------------------------------------------

data "template_file" "identity_iam_backend_config" {
  template = "${file("templates/backend/s3_config_init.tpl")}"
  vars {
    service = "identity_iam"
    path = "identity/iam/"
    fullaccess_group = "identity.iam.fullaccess"
    readonlyaccess_group = "identiy.iam.readonlyaccess"
  }
}

resource "null_resource" "identity_iam_backend_config" {
    depends_on = ["null_resource.identity_iam_directory"]

    provisioner "local-exec" {
        command = "echo \"${data.template_file.identity_iam_backend_config.rendered}\" > ./identity/iam/tfstate_backend_config.tf"
    }
}

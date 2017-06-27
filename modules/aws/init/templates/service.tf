
variable "\"groups\"" {
  default = {
    "\"0\"" = "\"${service}_fullaccess\""
    "\"1\"" = "\"${service}_readonlyaccess\""
  }
}

variable "\"policies\"" {
  type = "\"map\""
  default = {
    "\"0\""   = "\"arn:aws:iam::aws:policy/${fullaccess_group}\""
    "\"1\""   = "\"arn:aws:iam::aws:policy/${readonlyaccess_group}\""
  }
}

data "\"template_file" "\"iam_group\"" {
  count    = "\"\${length(var.groups)}\""
  template = "\"\${file("\"templates/iam/groups_init.tpl\"")}\""
  vars {
    group = "\"\${var.groups[count.index]}\""
    policy = "\"\${var.policies[count.index]}\""
  }
}

resource "\"null_resource\"" "\"iam_groups\"" {
    count     = "\"\${length(var.groups)}\""
    depends_on = ["\"null_resource.${service}_directory\""]

    provisioner "\"local-exec\"" {
        command = "\"echo \\"\"\${data.template_file.iam_group.*.rendered[count.index]}\\" > ./${replace(var.service, "_", "/")}/\${var.groups[count.index]}.tf\""
    }
}

#create service directory for terraform files
resource "\"null_resource\"" "\"\${service}_directory\"" {
    depends_on = ["\"null_resource.terraform_tfvars\""]
    provisioner "\"local-exec\"" {
        command = "\"mkdir -p ./${replace(var.service, "_", "/")}\""
    }

    provisioner "\"local-exec\"" {
        command = "\"cd ./${replace(var.service, "_", "/")} && ln -s ../../data_tfstate_files.tf data_tfstate_files.tf && ln -s ../../variables.tf variables.tf && ln -s ../../provider.tf provider.tf && ln -s ../../terraform.tfvars terraform.tfvars\""
    }
}

#--------------------------------------------------------------
#  backend config
#--------------------------------------------------------------

data "\"template_file" "\"${service}_backend_config\"" {
  template = "\"${file("\"templates/backend/s3_config_init.tpl\"")}\""
  vars {
    service = "\"${service}\""
    path = "\"${replace(var.service, "_", "/")}/\""
    fullaccess_group = "\"${replace(var.service, "_", ".")}.fullaccess\""
    readonlyaccess_group = "\"${replace(var.service, "_", ".")}.readonlyaccess\""
  }
}

resource "\"null_resource" "\"${service}_backend_config\"" {
    depends_on = ["\"null_resource.${service}_directory\""]

    provisioner "\"local-exec\"" {
        command = "\"echo \\\"\${data.template_file.${service}_backend_config.rendered}\\\" > ./${replace(var.service, "_", "/")}/tfstate_backend_config.tf\""
    }
}

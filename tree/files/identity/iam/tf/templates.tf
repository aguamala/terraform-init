#--------------------------------------------------------------
# users
#--------------------------------------------------------------
data "template_file" "users" {
  count    = "${length(var.users_templates)}"
  template = "${file("templates/user.tpl")}"

  vars {
    user = "${var.users_templates[count.index]}"
  }
}

resource "null_resource" "users" {
  count = "${length(var.users_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./user_${var.users_templates[count.index]}.tf ]; then echo \"${data.template_file.users.*.rendered[count.index]}\" > ./user_${var.users_templates[count.index]}.tf; fi"
  }

  triggers {
    users = "${join(",", var.users_templates)}"
  }

}

#--------------------------------------------------------------
# managed policy
#--------------------------------------------------------------
data "template_file" "managed_policies" {
  count    = "${length(var.managed_policies_templates)}"
  template = "${file("templates/managed_policy.tpl")}"

  vars {
    policy_name        = "${var.managed_policies_templates[count.index]}"
    policy_arn         = "${lookup(var.managed_policies,var.managed_policies_templates[count.index],"")}"
    policy_description = "${lookup(var.managed_policies_description,var.managed_policies_templates[count.index],"")}"
  }
}

resource "null_resource" "managed_policies" {
  count = "${length(var.managed_policies_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./policy_attachment_${var.managed_policies_templates[count.index]}.tf ]; then echo \"${data.template_file.managed_policies.*.rendered[count.index]}\" > ./policy_attachment_${var.managed_policies_templates[count.index]}.tf; fi"
  }

  triggers {
    mpt = "${join(",", var.managed_policies_templates)}"
  }
}

#--------------------------------------------------------------
# managed policy with group
#--------------------------------------------------------------
data "template_file" "managed_policies_groups" {
  count    = "${length(var.managed_policies_groups_templates)}"
  template = "${file("templates/managed_policy_group.tpl")}"

  vars {
    policy_name        = "${var.managed_policies_groups_templates[count.index]}"
    policy_arn         = "${lookup(var.managed_policies,var.managed_policies_groups_templates[count.index],"")}"
    policy_description = "${lookup(var.managed_policies_description,var.managed_policies_groups_templates[count.index],"")}"
  }
}

resource "null_resource" "managed_policies_groups" {
  count = "${length(var.managed_policies_groups_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./group_${var.managed_policies_groups_templates[count.index]}.tf ]; then echo \"${data.template_file.managed_policies_groups.*.rendered[count.index]}\" > ./group_${var.managed_policies_groups_templates[count.index]}.tf; fi"
  }

  triggers {
    mpgt = "${join(",", var.managed_policies_groups_templates)}"
  }
}

#--------------------------------------------------------------
# custom policy
#--------------------------------------------------------------

data "template_file" "custom_policies" {
  count    = "${length(var.custom_policies_templates)}"
  template = "${file("templates/custom_policy.tpl")}"

  vars {
    policy_name = "${var.custom_policies_templates[count.index]}"
  }
}

resource "null_resource" "custom_policies" {
  count = "${length(var.custom_policies_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./policy_${var.custom_policies_templates[count.index]}.tf ]; then echo \"${data.template_file.custom_policies.*.rendered[count.index]}\" > ./policy_${var.custom_policies_templates[count.index]}.tf; fi"
  }

  triggers {
    cpt = "${join(",", var.custom_policies_templates)}"
  }
}

#--------------------------------------------------------------
# custom policy with group
#--------------------------------------------------------------
data "template_file" "custom_policies_groups" {
  count    = "${length(var.custom_policies_groups_templates)}"
  template = "${file("templates/custom_policy_group.tpl")}"

  vars {
    policy_name = "${var.custom_policies_groups_templates[count.index]}"
  }
}

resource "null_resource" "custom_policies_groups" {
  count = "${length(var.custom_policies_groups_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./group_${var.custom_policies_groups_templates[count.index]}.tf ]; then echo \"${data.template_file.custom_policies_groups.*.rendered[count.index]}\" > ./group_${var.custom_policies_groups_templates[count.index]}.tf; fi"
  }

  triggers {
    cpgt = "${join(",", var.custom_policies_groups_templates)}"
  }
}

#--------------------------------------------------------------
# custom terraform policy with group
#--------------------------------------------------------------
data "template_file" "terraform_policy_group" {
  template = "${file("templates/terraform_policy_group.tpl")}"
}

resource "null_resource" "terraform_policy_group" {
  provisioner "local-exec" {
    command = "if [ ! -f ./group_TerraformBucketReadOnlyAccess.tf ]; then echo \"${data.template_file.terraform_policy_group.rendered}\" > ./group_TerraformBucketReadOnlyAccess.tf; fi"
  }
}

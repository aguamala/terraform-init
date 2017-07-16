#--------------------------------------------------------------
# users
#--------------------------------------------------------------
data "template_file" "users" {
  count    = "${var.service == "IAM" ? 1 : 0}"
  template = "${file("${path.module}/templates/identity/iam/users.tpl")}"
  vars {
    modules_path     = "${var.modules_path}"
    modules_ref      = "${var.modules_ref}"
   }
}

resource "null_resource" "users" {
  count      = "${var.service == "IAM" ? 1 : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "if [ ! -f ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/users.tf ]; then echo \"${data.template_file.users.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/users.tf; fi"
  }
}

#--------------------------------------------------------------
# managed policy
#--------------------------------------------------------------

data "template_file" "managed_policy" {
  count    = "${var.service == "IAM" &&  ! var.group && ! var.custom ? length(var.policies) : 0}"
  template = "${file("${path.module}/templates/identity/iam/managed_policy.tpl")}"

  vars {
    policy_name        = "${var.policies[count.index]}"
    policy_arn         = "${lookup(var.managed_policies,var.policies[count.index],"")}"
    policy_description = "${lookup(var.managed_policies_description,var.policies[count.index],"")}"
  }
}

resource "null_resource" "managed_policy" {
  count      = "${var.service == "IAM" &&  ! var.group && ! var.custom ? length(var.policies) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "if [ ! -f ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/policy_attachment_${var.policies[count.index]}.tf ]; then echo \"${data.template_file.managed_policy.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/policy_attachment_${var.policies[count.index]}.tf; fi"
  }
}

#--------------------------------------------------------------
# managed policy with group
#--------------------------------------------------------------
data "template_file" "managed_policy_group" {
  count    = "${var.service == "IAM" &&  var.group && ! var.custom ? length(var.policies) : 0}"
  template = "${file("${path.module}/templates/identity/iam/managed_policy_group.tpl")}"

  vars {
    policy_name        = "${var.policies[count.index]}"
    policy_arn         = "${lookup(var.managed_policies,var.policies[count.index],"")}"
    policy_description = "${lookup(var.managed_policies_description,var.policies[count.index],"")}"
  }
}

resource "null_resource" "managed_policy_group" {
  count      = "${var.service == "IAM" &&  var.group && ! var.custom ? length(var.policies) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "if [ ! -f ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/group_${var.policies[count.index]}.tf ]; then echo \"${data.template_file.managed_policy_group.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/group_${var.policies[count.index]}.tf; fi"
  }
}

#--------------------------------------------------------------
# custom policy
#--------------------------------------------------------------

data "template_file" "custom_policy" {
  count    = "${var.service == "IAM" &&  ! var.group && var.custom ? length(var.policies) : 0}"
  template = "${file("${path.module}/templates/identity/iam/custom_policy.tpl")}"

  vars {
    policy_name = "${var.policies[count.index]}"
  }
}

resource "null_resource" "custom_policy" {
  count      = "${var.service == "IAM" &&  ! var.group &&  var.custom ? length(var.policies) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "if [ ! -f ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/policy_${var.policies[count.index]}.tf ]; then echo \"${data.template_file.custom_policy.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/policy_${var.policies[count.index]}.tf; fi"
  }
}

#--------------------------------------------------------------
# custom policy with group
#--------------------------------------------------------------
data "template_file" "custom_policy_group" {
  count    = "${var.service == "IAM" &&  var.group &&  var.custom ? length(var.policies) : 0}"
  template = "${file("${path.module}/templates/identity/iam/custom_policy_group.tpl")}"

  vars {
    policy_name = "${var.policies[count.index]}"
  }
}

resource "null_resource" "custom_policy_group" {
  count      = "${var.service == "IAM" &&  var.group &&  var.custom ? length(var.policies) : 0}"
  depends_on = ["null_resource.service_directory"]

  provisioner "local-exec" {
    command = "if [ ! -f ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/group_${var.policies[count.index]}.tf ]; then echo \"${data.template_file.custom_policy_group.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/group_${var.policies[count.index]}.tf; fi"
  }
}

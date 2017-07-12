#--------------------------------------------------------------
# create tf files for IAM service admin groups
#--------------------------------------------------------------
data "template_file" "admin_group" {
  count    = "${var.service == "IAM" ? length(var.default_groups) : 0}"
  template = "${file("${path.module}/templates/identity/iam/group.tpl")}"

  vars {
    resource_name     = "${var.service}_administrator_${var.default_groups[count.index]}"
    group_name        = "${var.default_groups[count.index]}"
    group_policy      = "${lookup(var.default_groups_policies,var.default_groups[count.index],"")}"
    group_description = "${lookup(var.default_groups_policies_description,var.default_groups[count.index],"")}"
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
# create tf files for IAM service fullaccess groups
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
    command = "echo \"${data.template_file.fullaccess_groups.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/fullaccess_group_${var.fullaccess_groups[count.index]}.tf"
  }
}

#--------------------------------------------------------------
# create tf files for IAM service readonlyaccess groups
#--------------------------------------------------------------
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
    command = "echo \"${data.template_file.readonlyaccess_groups.*.rendered[count.index]}\" > ./${replace(lookup(var.service_names,var.service,var.service), "_", "/")}/readonly_group_${var.readonlyaccess_groups[count.index]}.tf"
  }
}

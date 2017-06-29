#--------------------------------------------------------------
# Terraform tfstate file modifier groups
#--------------------------------------------------------------

resource "aws_iam_policy_attachment" "fullaccess" {
  name       = "tfstate_${replace(var.tfstate_path, "/", "_")}fullaccess"
  users      = "${var.tfstate_fullaccess_users}"
  roles      = "${var.tfstate_fullaccess_roles}"
  groups     = "${var.tfstate_fullaccess_groups}"
  policy_arn = "${aws_iam_policy.remote_state_config.arn}"
}

resource "aws_iam_policy_attachment" "readonlyaccess" {
  name       = "tfstate_${replace(var.tfstate_path, "/", "_")}readonlyaccess"
  users      = "${var.tfstate_readonlyaccess_users}"
  roles      = "${var.tfstate_readonlyaccess_roles}"
  groups     = "${var.tfstate_readonlyaccess_groups}"
  policy_arn = "${aws_iam_policy.readonly_remote_state_config.arn}"
}

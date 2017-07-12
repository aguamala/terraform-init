#--------------------------------------------------------------
# Terraform tfstate file modifier groups
#--------------------------------------------------------------

resource "aws_iam_policy_attachment" "write" {
  name       = "tfstate_${replace(var.tfstate_path, "/", "_")}write"
  users      = "${var.tfstate_write_users}"
  roles      = "${var.tfstate_write_roles}"
  groups     = "${var.tfstate_write_groups}"
  policy_arn = "${aws_iam_policy.remote_state_config.arn}"
}

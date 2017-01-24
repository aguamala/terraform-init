#--------------------------------------------------------------
# Terraform state modifier groups
#--------------------------------------------------------------

resource "aws_iam_policy_attachment" "fullaccess" {
    name = "tf_state_${replace(var.tf_state_path, "/", "_")}_fullaccess"
    users = "${var.tf_state_fullaccess_users}"
    roles = "${var.tf_state_fullaccess_roles}"
    groups = "${var.tf_state_fullaccess_groups}"
    policy_arn = "${aws_iam_policy.remote_state_config.arn}"
}

resource "aws_iam_policy_attachment" "readonlyaccess" {
    name = "tf_state_${replace(var.tf_state_path, "/", "_")}_readonlyaccess"
    users = "${var.tf_state_readonlyaccess_users}"
    roles = "${var.tf_state_readonlyaccess_roles}"
    groups = "${var.tf_state_readonlyaccess_groups}"
    policy_arn = "${aws_iam_policy.readonly_remote_state_config.arn}"
}

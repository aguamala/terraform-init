#--------------------------------------------------------------------------------------
# This module is used to create an AWS IAM group and attach policy to users and roles
#--------------------------------------------------------------------------------------
resource "aws_iam_group" "mod" {
  name = "${var.name}"
}

resource "aws_iam_group_membership" "mod" {
  depends_on = ["aws_iam_group.mod"]
  name       = "${var.name}-groupmembership"
  users      = "${var.group_users}"
  group      = "${var.name}"
}

resource "aws_iam_policy_attachment" "mod" {
  depends_on = ["aws_iam_group.mod"]
  name       = "${var.name}-policy-attachment"
  users      = "${var.policy_users}"
  roles      = "${var.roles}"
  groups     = ["${var.name}"]
  policy_arn = "${var.policy}"
}

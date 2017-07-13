resource "aws_iam_user" "mod" {
  count = "${length(var.users)}"
  name  = "${var.users[count.index]}"
  path  = "${var.users_path}"
}

resource "aws_iam_user" "mod" {
  name = "${var.name}"
  path = "${var.path}"
}

resource "aws_iam_user_ssh_key" "mod" {
  count      = "${length(var.ssh_keys)}"
  username   = "${aws_iam_user.mod.name}"
  encoding   = "${var.ssh_keys_encoding}"
  public_key = "${var.ssh_keys[count.index]}"
}

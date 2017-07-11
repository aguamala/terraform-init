output "name" {
  value = ["${aws_iam_group.mod.name}"]
}

output "users" {
  value = ["${aws_iam_group_membership.mod.*.users}"]
}

output "policy" {
  value = "${aws_iam_policy_attachment.mod.name}"
}

output "policy_id" {
  value = "${aws_iam_policy_attachment.mod.id}"
}

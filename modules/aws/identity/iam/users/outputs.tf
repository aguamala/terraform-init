output "arn" {
  value = ["${aws_iam_user.mod.*.arn}"]
}

output "name" {
  value = ["${aws_iam_user.mod.*.name}"]
}

output "unique_id" {
  value = ["${aws_iam_user.mod.*.unique_id}"]
}

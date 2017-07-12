output "id" {
  value = "${aws_s3_bucket.mod.id}"
}

output "arn" {
  value = "${aws_s3_bucket.mod.arn}"
}

output "readonly_policy_name" {
  value = "${aws_iam_policy.readonly_policy.name}"
}

output "readonly_policy_arn" {
  value = "${aws_iam_policy.readonly_policy.arn}"
}

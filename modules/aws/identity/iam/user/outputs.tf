output "arn" {
  value = ["${aws_iam_user.mod.arn}"]
}

output "name" {
  value = ["${aws_iam_user.mod.name}"]
}

output "unique_id" {
  value = ["${aws_iam_user.mod.unique_id}"]
}

output "ssh_public_key_id" {
  value = ["${aws_iam_user_ssh_key.mod.ssh_public_key_id}"]
}

output "fingerprint" {
  value = ["${aws_iam_user_ssh_key.mod.fingerprint}"]
}

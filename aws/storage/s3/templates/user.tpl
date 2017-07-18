#--------------------------------------------------------------
# IAM user ${user}
#--------------------------------------------------------------

variable "\"ssh_keys\"" {
  default = []
}

variable "\"pem_keys\"" {
  default = []
}

resource "\"aws_iam_user\"" "\"${user}\"" {
  name = "\"${user}\""
  path = "\"/\""
}

resource "\"aws_iam_user_ssh_key\"" "\"${user}_ssh\"" {
  count      = "\"${length(var.ssh_keys)}\""
  username   = "\"${aws_iam_user.mod.name}\""
  encoding   = "\"SSH\""
  public_key = "\"${var.ssh_keys[count.index]}\""
}

resource "\"aws_iam_user_ssh_key\"" "\"${user}_pem\"" {
  count      = "\"${length(var.pem_keys)}\""
  username   = "\"${aws_iam_user.mod.name}\""
  encoding   = "\"PEM\""
  public_key = "\"${var.pem_keys[count.index]}\""
}

output "\"arn\"" {
  value = ["\"${aws_iam_user.${user}.arn}\""]
}

output "\"name\"" {
  value = ["\"${aws_iam_user.${user}.name}\""]
}

output "\"unique_id\"" {
  value = ["\"${aws_iam_user.${user}.unique_id}\""]
}

output "\"ssh_public_keys_id\"" {
  value = ["\"${aws_iam_user_ssh_key.${user}_ssh.*.ssh_public_key_id}\""]
}

output "\"pem_public_keys_id\"" {
  value = ["\"${aws_iam_user_ssh_key.${user}_pem.*.ssh_public_key_id}\""]
}

output "\"ssh_fingerprints\"" {
  value = ["\"${aws_iam_user_ssh_key.${user}_ssh.*.fingerprint}\""]
}

output "\"pem_fingerprints\"" {
  value = ["\"${aws_iam_user_ssh_key.${user}_pem.*.fingerprint}\""]
}

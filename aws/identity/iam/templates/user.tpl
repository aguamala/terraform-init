#--------------------------------------------------------------
# IAM user ${user}
#--------------------------------------------------------------

variable "\"${user}_ssh_keys\"" {
  default = []
}

variable "\"${user}_pem_keys\"" {
  default = []
}

resource "\"aws_iam_user\"" "\"${user}\"" {
  name = "\"${user}\""
  path = "\"/\""
}

resource "\"aws_iam_user_ssh_key\"" "\"${user}_ssh\"" {
  count      = "\"\$\{length\(var.${user}_ssh_keys\)\}\""
  username   = "\"\$\{aws_iam_user.${user}.name\}\""
  encoding   = "\"SSH\""
  public_key = "\"\$\{var.${user}_ssh_keys[count.index]\}\""
}

resource "\"aws_iam_user_ssh_key\"" "\"${user}_pem\"" {
  count      = "\"\$\{length\(var.${user}_pem_keys\)\}\""
  username   = "\"\$\{aws_iam_user.${user}.name\}\""
  encoding   = "\"PEM\""
  public_key = "\"\$\{var.${user}_pem_keys[count.index]\}\""
}

output "\"${user}_arn\"" {
  value = ["\"\$\{aws_iam_user.${user}.arn\}\""]
}

output "\"${user}_name\"" {
  value = ["\"\$\{aws_iam_user.${user}.name\}\""]
}

output "\"${user}_unique_id\"" {
  value = ["\"\$\{aws_iam_user.${user}.unique_id\}\""]
}

output "\"${user}_ssh_public_keys_id\"" {
  value = ["\"\$\{aws_iam_user_ssh_key.${user}_ssh.*.ssh_public_key_id\}\""]
}

output "\"${user}_pem_public_keys_id\"" {
  value = ["\"\$\{aws_iam_user_ssh_key.${user}_pem.*.ssh_public_key_id\}\""]
}

output "\"${user}_ssh_fingerprints\"" {
  value = ["\"\$\{aws_iam_user_ssh_key.${user}_ssh.*.fingerprint\}\""]
}

output "\"${user}_pem_fingerprints\"" {
  value = ["\"\$\{aws_iam_user_ssh_key.${user}_pem.*.fingerprint\}\""]
}

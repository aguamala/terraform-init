#--------------------------------------------------------------
# TerraformBucketReadOnlyAccess IAM policy attachment
# TerraformBucketReadOnlyAccess IAM group
#--------------------------------------------------------------
resource "\"aws_iam_policy_attachment\"" "\"TerraformBucketReadOnlyAccess\"" {
  name       = "\"TerraformBucketReadOnlyAccess-policy-attachment\""
  users      = []
  roles      = []
  groups     = ["\"\$\{aws_iam_group.TerraformBucketReadOnlyAccess.name\}\""]
  policy_arn = "\"\$\{data.terraform_remote_state.file.module_backend_s3_bucket_readonly_policy_arn\}\""
}

resource "\"aws_iam_group\"" "\"TerraformBucketReadOnlyAccess\"" {
  name = "\"TerraformBucketReadOnlyAccess\""
}

resource "\"aws_iam_group_membership\"" "\"TerraformBucketReadOnlyAccess\"" {
  name       = "\"TerraformBucketReadOnlyAccess-groupmembership\""
  users      = []
  group      = "\"\$\{aws_iam_group.TerraformBucketReadOnlyAccess.name\}\""
}

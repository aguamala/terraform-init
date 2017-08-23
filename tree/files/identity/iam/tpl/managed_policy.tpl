#--------------------------------------------------------------
# ${policy_name} IAM policy attachment
# ${policy_description}
# WARNING: must specify at least one user or role or group to create
#--------------------------------------------------------------

resource "\"aws_iam_policy_attachment\"" "\"${policy_name}\"" {
  name       = "\"${policy_name}-policy-attachment\""
  users      = []
  roles      = []
  groups     = []
  policy_arn = "\"${policy_arn}\""
}

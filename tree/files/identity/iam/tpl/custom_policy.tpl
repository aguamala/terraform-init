#-------------------------------------------------------------------
# ${policy_name} IAM policy attachment
# WARNING: must specify at least one user or role or group to create
#--------------------------------------------------------------------
data "\"aws_iam_policy_document\"" "\"${policy_name}\"" {
  statement {
    sid = "\"1\""

    actions = [
      "\"ec2:Describe*\""
    ]

    resources = [
      "\"*\"",
    ]
  }
}

resource "\"aws_iam_policy\"" "\"${policy_name}\"" {
  name        = "\"${policy_name}\""
  description = "\"\""
  policy = "\"\$\{data.aws_iam_policy_document.${policy_name}.json\}\""
}

resource "\"aws_iam_policy_attachment\"" "\"${policy_name}\"" {
  name       = "\"${policy_name}-policy-attachment\""
  users      = []
  roles      = []
  groups     = []
  policy_arn = "\"\$\{aws_iam_policy.${policy_name}.arn\}\""
}

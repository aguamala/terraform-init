#--------------------------------------------------------------
# ${policy_name} IAM policy attachment
# ${policy_name} IAM group
#--------------------------------------------------------------
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
  groups     = ["\"\$\{aws_iam_group.${policy_name}.name\}\""]
  policy_arn = "\"\$\{aws_iam_policy.${policy_name}.arn\}\""
}

resource "\"aws_iam_group\"" "\"${policy_name}\"" {
  name = "\"${policy_name}\""
}

resource "\"aws_iam_group_membership\"" "\"${policy_name}\"" {
  name       = "\"${policy_name}-groupmembership\""
  users      = []
  group      = "\"\$\{aws_iam_group.${policy_name}.name\}\""
}

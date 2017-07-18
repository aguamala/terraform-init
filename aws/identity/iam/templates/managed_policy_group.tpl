#--------------------------------------------------------------
# ${policy_name} IAM policy attachment
# ${policy_description}
# ${policy_name} IAM group
#--------------------------------------------------------------

resource "\"aws_iam_policy_attachment\"" "\"${policy_name}\"" {
  name       = "\"${policy_name}-policy-attachment\""
  users      = []
  roles      = []
  groups     = ["\"\$\{aws_iam_group.${policy_name}.name\}\""]
  policy_arn = "\"${policy_arn}\""
}

resource "\"aws_iam_group\"" "\"${policy_name}\"" {
  name = "\"${policy_name}\""
}

resource "\"aws_iam_group_membership\"" "\"${policy_name}\"" {
  name       = "\"${policy_name}-groupmembership\""
  users      = []
  group      = "\"\$\{aws_iam_group.${policy_name}.name\}\""
}

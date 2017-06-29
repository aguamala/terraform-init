#--------------------------------------------------------------
# ${group_name} user groups
#--------------------------------------------------------------
resource "\"aws_iam_group\"" "\"${resource_name}\"" {
    name = "\"${group_name}\""
}

#--------------------------------------------------------------
# ${group_name} group membership (for users)
#--------------------------------------------------------------
resource "\"aws_iam_group_membership\"" "\"${resource_name}\"" {
    name = "\"${replace("\"${group_name}\"", ".", "-")}-groupmembership\""
    users = []
    group = "\"\$\{aws_iam_group.${group_name}.name\}\""
}

#--------------------------------------------------------------
# ${group_name} policy attachment (for roles and users)
#--------------------------------------------------------------
resource "\"aws_iam_policy_attachment\"" "\"${resource_name}\"" {
    name = "\"${replace("\"${group_name}\"", ".", "-")}-policy-attachment\""
    users = []
    roles = []
    groups = ["\"\$\{aws_iam_group.${group_name}.name\}\""]
    policy_arn = "\"${policy}\""
}

#--------------------------------------------------------------
# ${group} user groups
#--------------------------------------------------------------
resource "\"aws_iam_group\"" "\"${group}\"" {
    depends_on = ["\"null_resource.links\""]
    name = "\"${replace("\"${group}\"", "_", ".")}\""
    path = "\"/${replace("\"${group}\"", "_", "/")}/\""
}

#--------------------------------------------------------------
# ${group} group membership (for users)
#--------------------------------------------------------------
resource "\"aws_iam_group_membership\"" "\"${group}\"" {
    name = "\"${group}_group_membership\""
    name = "\"${replace("\"${group}\"", "_", "")}groupmembership\""
    users = []
    group = "\"\$\{aws_iam_group.${group}.name\}\""
}

#--------------------------------------------------------------
# ${group} policy attachment (for roles and users)
#--------------------------------------------------------------
resource "\"aws_iam_policy_attachment\"" "\"${group}\"" {
    name = "\"${group}_policy_attachment\""
    #users = []
    roles = []
    groups = ["\"\$\{aws_iam_group.${group}.name\}\""]
    policy_arn = "\"${policy}\""
}

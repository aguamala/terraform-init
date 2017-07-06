
#--------------------------------------------------------------
# ${group_name} IAM group
#--------------------------------------------------------------

module "\"${resource_name}\"" {
    source      = "\"../../../modules/aws/identity/iam/group\""
    name        = "\"${group_name}\""
    group_users = []
    roles       = []
    policy      = "\"${group_policy}\""
}

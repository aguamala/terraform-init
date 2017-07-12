
#--------------------------------------------------------------
# ${group_name} IAM group
# ${group_description}
#--------------------------------------------------------------

module "\"${resource_name}\"" {
    source      = "\"../../../modules/aws/identity/iam/group\""
    name        = "\"${group_name}\""
    group_users = []
    roles       = []
    policy      = "\"${group_policy}\""
}

output "\"module_${resource_name}_name\"" {
  value = "\"\$\{module.${resource_name}.name\}\""
}

output "\"module_${resource_name}_users\"" {
  value = "\"\$\{module.${resource_name}.users\}\""
}

output "\"module_${resource_name}_policy\"" {
  value = "\"\$\{module.${resource_name}.policy\}\""
}

output "\"module_${resource_name}_policy_id\"" {
  value = "\"\$\{module.${resource_name}.policy_id\}\""
}

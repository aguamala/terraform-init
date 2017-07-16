#--------------------------------------------------------------
# IAM users
#--------------------------------------------------------------

module "\"adminstrators\"" {
  source      = "\"${modules_path}/modules/aws/identity/iam/users${modules_ref}\""
  users       = []
  users_path  = "\"/administrators/\""
}

#module "\"developers\"" {
#  source      = "\"${modules_path}/modules/aws/identity/iam/users${modules_ref}\""
#  users      = []
#  users_path = "\"/developers/\""
#}

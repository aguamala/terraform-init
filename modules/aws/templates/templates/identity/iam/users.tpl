#--------------------------------------------------------------
# IAM users
#--------------------------------------------------------------

module "\"adminstrators\"" {
  source      = "\"../../../modules/aws/identity/iam/users\""
  users       = []
  users_path  = "\"/administrators\""
}

#module "\"developers\"" {
#  source     = "\"../../../modules/aws/identity/iam/users\""
#  users      = []
#  users_path = "\"/developers\""
#}

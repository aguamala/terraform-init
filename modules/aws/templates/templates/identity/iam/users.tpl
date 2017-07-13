#--------------------------------------------------------------
# IAM users
#--------------------------------------------------------------

module "\"adminstrators\"" {
  source      = "\"github.com/aguamala/terraform-init//modules/aws/identity/iam/users?ref=v0.4\""
  users       = []
  users_path  = "\"/administrators/\""
}

#module "\"developers\"" {
#  source     = "\"github.com/aguamala/terraform-init//modules/aws/identity/iam/users?ref=v0.4\""
#  users      = []
#  users_path = "\"/developers/\""
#}

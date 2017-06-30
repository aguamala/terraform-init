#--------------------------------------------------------------
# identity iam users, groups and policies
#
# LIMTIS
# http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html
# user 10 groups
#--------------------------------------------------------------

module "templates_identity_iam" {
  source  = "../modules/aws/templates/init"
  service = "identity_iam"
}

module "storage_s3" {
  source  = "../modules/aws/templates/init"
  service = "storage_s3"
}

module "networking_vpc" {
  source  = "../modules/aws/templates/init"
  service = "networking_vpc"
  environment = "devel"
}

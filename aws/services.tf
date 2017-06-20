#--------------------------------------------------------------
# identity iam users, groups and policies
#
# LIMTIS
# http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html
# user 10 groups
#--------------------------------------------------------------

module "identity_iam" {
    source = "../modules/aws/init"
    service = "identity_iam"
}

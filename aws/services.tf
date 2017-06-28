#--------------------------------------------------------------
# identity iam users, groups and policies
#
# LIMTIS
# http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html
# user 10 groups
#--------------------------------------------------------------

module "identity_iam" {
  source  = "../modules/aws/init"
  service = "identity_iam"

  groups = {
    "0" = "identity_iam_fullaccess"
    "1" = "identiy_iam_readonlyaccess"
  }

  policies = {
    "0" = "arn:aws:iam::aws:policy/IAMFullAccess"
    "1" = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  }
}

#module "proborsor" {
#    source    = "../modules/aws/init"
#    service   = "proborsor"
#    groups    = { 0 = "identity_iam_fullaccess", 1 = "identiy_iam_readonlyaccess" }
#    policies  = { 0 = "arn:aws:iam::aws:policy/IAMFullAccess", 1 = "arn:aws:iam::aws:policy/IAMReadOnlyAccess" }
#}


#resource "aws_iam_user" "user" {
#  count = "${length(split(",", var.users))}"
#  name  = "${element(split(",", var.users), count.index)}"
#}


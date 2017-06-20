#--------------------------------------------------------------
# identity_iam_fullaccess user groups
#--------------------------------------------------------------
resource "aws_iam_group" "identity_iam_fullaccess" {
    name = "identity.iam.fullaccess"
    path = "/identity/iam/fullaccess/"
}

#--------------------------------------------------------------
# identity_iam_fullaccess group membership (for users)
#--------------------------------------------------------------
resource "aws_iam_group_membership" "identity_iam_fullaccess" {
    name = "identity_iam_fullaccess_group_membership"
    name = "identityiamfullaccessgroupmembership"
    users = []
    group = "${aws_iam_group.identity_iam_fullaccess.name}"
}

#--------------------------------------------------------------
# identity_iam_fullaccess policy attachment (for roles and users)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "identity_iam_fullaccess" {
    name = "identity_iam_fullaccess_policy_attachment"
    #users = []
    roles = []
    groups = ["${aws_iam_group.identity_iam_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}


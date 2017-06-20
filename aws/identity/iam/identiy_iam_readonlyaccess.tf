#--------------------------------------------------------------
# identiy_iam_readonlyaccess user groups
#--------------------------------------------------------------
resource "aws_iam_group" "identiy_iam_readonlyaccess" {
    name = "identiy.iam.readonlyaccess"
    path = "/identiy/iam/readonlyaccess/"
}

#--------------------------------------------------------------
# identiy_iam_readonlyaccess group membership (for users)
#--------------------------------------------------------------
resource "aws_iam_group_membership" "identiy_iam_readonlyaccess" {
    name = "identiy_iam_readonlyaccess_group_membership"
    name = "identiyiamreadonlyaccessgroupmembership"
    users = []
    group = "${aws_iam_group.identiy_iam_readonlyaccess.name}"
}

#--------------------------------------------------------------
# identiy_iam_readonlyaccess policy attachment (for roles and users)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "identiy_iam_readonlyaccess" {
    name = "identiy_iam_readonlyaccess_policy_attachment"
    #users = []
    roles = []
    groups = ["${aws_iam_group.identiy_iam_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}


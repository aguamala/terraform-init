#--------------------------------------------------------------
# Identity policy attachment (defaults group)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "identity_iam_fullaccess" {
    name = "iamfullaccess"
    users = ["${var.aws_user_bucket_creator}"] #aws_terraform_user this will change previous manual granted policy
    #roles = []
    groups = ["${aws_iam_group.identity_iam_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_policy_attachment" "identity_iam_readonlyaccess" {
    name = "iamreadonlyaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.identity_iam_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

#--------------------------------------------------------------
# Networking policy attachment (defaults group)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "networking_vpc_fullaccess" {
    name = "vpcfullaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.networking_vpc_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "networking_vpc_readonlyaccess" {
    name = "vpcreadonlyaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.networking_vpc_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess"
}

#--------------------------------------------------------------
# Compute policy attachment (defaults group)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "compute_ec2_fullaccess" {
    name = "ec2fullaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.compute_ec2_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "compute_ec2_readonlyaccess" {
    name = "ec2readonlyaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.compute_ec2_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#--------------------------------------------------------------
# Storage policy attachment (defaults group)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "storage_s3_fullaccess" {
    name = "s3fullaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.storage_s3_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy_attachment" "storage_s3_readonlyaccess" {
    name = "s3readonlyaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.storage_s3_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

#--------------------------------------------------------------
# Database policy attachment (defaults group)
#--------------------------------------------------------------
resource "aws_iam_policy_attachment" "database_rds_fullaccess" {
    name = "rdsfullaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.database_rds_fullaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_policy_attachment" "database_rds_readonlyaccess" {
    name = "rdsreadonlyaccess"
    #users = []
    #roles = []
    groups = ["${aws_iam_group.database_rds_readonlyaccess.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

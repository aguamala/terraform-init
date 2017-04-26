#--------------------------------------------------------------
# Billing group
#--------------------------------------------------------------

resource "aws_iam_group" "billing_fullaccess" {
    name = "billing.fullaccess"
    path = "/billing/"
}

#--------------------------------------------------------------
# Identity groups
#--------------------------------------------------------------
resource "aws_iam_group" "identity_iam_fullaccess" {
    name = "identity.iam.fullaccess"
    path = "/identity/iam/"
}

resource "aws_iam_group" "identity_iam_readonlyaccess" {
    name = "identity.iam.readonlyaccess"
    path = "/readonly/identity/iam/"
}

#--------------------------------------------------------------
# Networking groups
#--------------------------------------------------------------
resource "aws_iam_group" "networking_vpc_fullaccess" {
    name = "networking.vpc.fullaccess"
    path = "/networking/vpc/"
}

resource "aws_iam_group" "networking_vpc_readonlyaccess" {
    name = "networking.vpc.readonlyaccess"
    path = "/readonly/networking/vpc/"
}

resource "aws_iam_group" "networking_route53_fullaccess" {
    name = "networking.route53.fullaccess"
    path = "/networking/route53/"
}

resource "aws_iam_group" "networking_route53_readonlyaccess" {
    name = "networking.route53.readonlyaccess"
    path = "/readonly/networking/route53/"
}

#--------------------------------------------------------------
# Compute groups
#--------------------------------------------------------------
resource "aws_iam_group" "compute_ec2_fullaccess" {
    name = "compute.ec2.fullaccess"
    path = "/compute/ec2/"
}

resource "aws_iam_group" "compute_ec2_readonlyaccess" {
    name = "compute.ec2.readonlyaccess"
    path = "/readonly/compute/ec2/"
}

resource "aws_iam_group" "compute_ecs_fullaccess" {
    name = "compute.ecs.fullaccess"
    path = "/compute/ecs/"
}

resource "aws_iam_group" "compute_ecs_readonlyaccess" {
    name = "compute.ecs.readonlyaccess"
    path = "/readonly/compute/ecs/"
}

resource "aws_iam_group" "compute_ecs_poweruser" {
    name = "compute.ecs.poweruser"
    path = "/poweruser/compute/ecs/"
}

#--------------------------------------------------------------
# Storage groups
#--------------------------------------------------------------
resource "aws_iam_group" "storage_s3_fullaccess" {
    name = "storage.s3.fullaccess"
    path = "/storage/s3/"
}

resource "aws_iam_group" "storage_s3_readonlyaccess" {
    name = "storage.s3.readonlyaccess"
    path = "/readonly/storage/s3/"
}

resource "aws_iam_group" "storage_efs_fullaccess" {
    name = "storage.efs.fullaccess"
    path = "/storage/efs/"
}

resource "aws_iam_group" "storage_efs_readonlyaccess" {
    name = "storage.efs.readonlyaccess"
    path = "/readonly/storage/efs/"
}

#--------------------------------------------------------------
# Database groups
#--------------------------------------------------------------
resource "aws_iam_group" "database_rds_fullaccess" {
    name = "database.rds.fullaccess"
    path = "/database/rds/"
}

resource "aws_iam_group" "database_rds_readonlyaccess" {
    name = "database.rds.readonlyaccess"
    path = "/readonly/database/rds/"
}

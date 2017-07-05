variable "domain" {
  type    = "string"
  default = "default"
}

variable "service" {
  type = "string"
}

variable "backend" {
  type    = "string"
  default = "s3"
}

variable "readonlyaccess_policies" {
  type = "map"

  default = {
    "identity_iam"   = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
    "compute_ec2"    = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
    "networking_vpc" = "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess"
    "storage_s3"     = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    "database_rds"   = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
  }
}

variable "fullaccess_policies" {
  type = "map"

  default = {
    "identity_iam"   = "arn:aws:iam::aws:policy/IAMFullAccess"
    "compute_ec2"    = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "networking_vpc" = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
    "storage_s3"     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    "database_rds"   = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  }
}

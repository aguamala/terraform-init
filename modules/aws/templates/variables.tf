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

variable "global_services" {
  type = "map"

  default = {
    "identity_iam" = true
    "storage_s3"   = true
  }
}

variable "service_names" {
  type = "map"

  default = {
    "identity_iam"   = "IAM"
    "compute_ec2"    = "AmazonEC2"
    "networking_vpc" = "AmazonVPC"
    "storage_s3"     = "AmazonS3"
    "database_rds"   = "AmazonRDS"
  }
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

variable "default_groups" {
  type    = "list"
  default = ["AdministratorAccess", "DatabaseAdministrator", "SystemAdministrator", "NetworkAdministrator", "ServiceCatalogAdminFullAccess", "ServiceCatalogAdminReadOnlyAccess", "AWSCodeBuildAdminAccess", "AmazonAPIGatewayAdministrator", "AmazonWorkSpacesAdmin", "AmazonWorkSpacesApplicationManagerAdminAccess"]
}

variable "default_groups_policies" {
  type = "map"

  default = {
    "AdministratorAccess"                           = "arn:aws:iam::aws:policy/AdministratorAccess"
    "DatabaseAdministrator"                         = "arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"
    "SystemAdministrator"                           = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
    "NetworkAdministrator"                          = "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
    "ServiceCatalogAdminFullAccess"                 = "arn:aws:iam::aws:policy/ServiceCatalogAdminFullAccess"
    "ServiceCatalogAdminReadOnlyAccess"             = "arn:aws:iam::aws:policy/ServiceCatalogAdminReadOnlyAccess"
    "AWSCodeBuildAdminAccess"                       = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
    "AmazonAPIGatewayAdministrator"                 = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
    "AmazonWorkSpacesAdmin"                         = "arn:aws:iam::aws:policy/AmazonWorkSpacesAdmin"
    "AmazonWorkSpacesApplicationManagerAdminAccess" = "arn:aws:iam::aws:policy/AmazonWorkSpacesApplicationManagerAdminAccess"
  }
}

variable "modules_path" {
  #default = "github.com/aguamala/terraform-init/"
  default = "/home/gabo/github.com/aguamala/terraform-init/"
}

variable "modules_ref" {
  #default = "?ref=v0.6"
  default = ""
}

variable "domain" {
  type    = "string"
  default = "default"
}

variable "service" {
  type = "string"
}

variable "global_services" {
  type = "map"

  default = {
    "IAM" = true
    "S3"  = true
  }
}

variable "service_names" {
  type = "map"

  default = {
    "IAM"     = "identity_iam"
    "EC2"     = "compute_ec2"
    "S3"      = "storage_s3"
    "RDS"     = "database_rds"
    "VPC"     = "networking_vpc"
    "Route53" = "networking_route53"
  }
}

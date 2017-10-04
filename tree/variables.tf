variable "init_path" {
   default = "./aguamala/"
}

variable "modules_path" {
  default = "github.com/aguamala/terraform-init/"
  #default = "/home/gabo/github.com/aguamala/terraform-init/"
}

variable "modules_ref" {
  default = "?ref=v0.14"

  #default = ""
}

variable "domain" {
  type    = "string"
  default = "default"
}

variable "services" {
  type = "list"

  default = [
    "IAM",
    "EC2",
    "ContainerService",
    "S3",
    "EFS",
    "RDS",
    "DynamoDB",
    "VPC",
    "Route53",
    "CodeCommit",
  ]
}

variable "global_services" {
  type = "list"

  default = [
    "IAM",
    "S3",
    "CodeCommit",
    "Route53",
  ]
}

variable "service_names" {
  type = "map"

  default = {
    "IAM"              = "identity_iam"
    "EC2"              = "compute_ec2"
    "ContainerService" = "compute_ecs"
    "S3"               = "storage_s3"
    "EFS"              = "storage_efs"
    "RDS"              = "database_rds"
    "DynamoDB"         = "database_dynamodb"
    "VPC"              = "networking_vpc"
    "Route53"          = "networking_route53"
    "CodeCommit"       = "developer_codecommit"
  }
}

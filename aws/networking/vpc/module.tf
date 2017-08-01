module "vpc" {
  source               = "github.com/aguamala/terraform-init//modules/aws/networking/vpc?ref=v0.11"
  name                 = "${var.name}"
  cidr                 = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  azs                  = "${var.azs}"
}


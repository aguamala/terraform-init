module "\"vpc\"" {
  source               = "\"${modules_path}/modules/aws/networking/vpc${modules_ref}\""
  name                 = "\"\$\{var.name\}\""
  cidr                 = "\"\$\{var.cidr\}\""
  enable_dns_hostnames = "\"\$\{var.enable_dns_hostnames\}\""
  enable_dns_support   = "\"\$\{var.enable_dns_support\}\""
  azs                  = "\"\$\{var.azs\}\""
}

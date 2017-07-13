module "\"${domain}_vpc\"" {
    source = "\"github.com/aguamala/terraform-init//modules/aws/networking/vpc?ref=v0.4\""
    name = "\"${domain}\""
    cidr = "\"172.30.0.0\/16\""
    enable_dns_hostnames = true
    enable_dns_support = true
    azs = []
}

output "\"module_${domain}_vpc_private_subnets\"" {
  value = "\"\$\{module.${domain}_vpc.private_subnets\}\""
}

output "\"module_${domain}_vpc_public_subnets\"" {
  value = "\"\$\{module.${domain}_vpc.public_subnets\}\""
}

output "\"module_${domain}_vpc_id\"" {
  value = "\"\$\{module.${domain}_vpc.id\}\""
}

output "\"module_${domain}_vpc_public_route_table_id\"" {
  value = "\"\$\{module.${domain}_vpc.public_route_table_id\}\""
}

output "\"module_${domain}_vpc_private_route_table_id\"" {
  value = "\"\$\{module.${domain}_vpc.private_route_table_id\}\""
}

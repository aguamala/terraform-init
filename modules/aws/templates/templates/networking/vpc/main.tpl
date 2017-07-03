module "\"${environment}_vpc\"" {
    source = "\"github.com/aguamala/terraform-init/modules/aws/networking//vpc\""
    name = "\"${environment}\""
    cidr = "\"172.30.0.0\/16\""
    enable_dns_hostnames = true
    enable_dns_support = true
    azs = []
}

output "\"module_${environment}_vpc_private_subnets\"" {
  value = "\"\$\{module.${environment}_vpc.private_subnets\}\""
}

output "\"module_${environment}_vpc_public_subnets\"" {
  value = "\"\$\{module.${environment}_vpc.public_subnets\}\""
}

output "\"module_${environment}_vpc_id\"" {
  value = "\"\$\{module.${environment}_vpc.id\}\""
}

output "\"module_${environment}_vpc_public_route_table_id\"" {
  value = "\"\$\{module.${environment}_vpc.public_route_table_id\}\""
}

output "\"module_${environment}_vpc_private_route_table_id\"" {
  value = "\"\$\{module.${environment}_vpc.private_route_table_id\}\""
}

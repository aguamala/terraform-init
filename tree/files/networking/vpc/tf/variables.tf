variable "name" {}
variable "cidr" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}

variable "azs" {
  default = []
}

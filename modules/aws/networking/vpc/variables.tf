variable "name" {}

variable "cidr" {}

variable "public_subnets" {
  description = "Number of public subnets inside the VPC."
  default     = 1
}

variable "private_subnets" {
  description = "Number of private subnets inside the VPC."
  default     = 1
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "tags" {
  description = "A map of tags to add"
  default     = {}
}

variable "cidrsubnet_newbits" {
  default = 8
}

variable "cidrsubnet_netnum_private" {
  default = 1
}

variable "cidrsubnet_netnum_public" {
  default = 101
}

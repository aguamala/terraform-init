variable "service" {
  type = "string"
}

variable "backend" {
  type    = "string"
  default = "s3"
}

variable "fullaccess_groups" {
  type    = "map"
  default = {}
}

variable "policies" {
  type    = "map"
  default = {}
}



variable "service" {
  type    = "string"
}

variable "backend" {
  type    = "string"
  default = "s3"
}

variable "groups" {
  type = "map"
  default = {
    "0" = "identity_iam_fullaccess"
    "1" = "identiy_iam_readonlyaccess"
  }
}

variable "policies" {
  type = "map"
  default = {
    "0"   = "arn:aws:iam::aws:policy/IAMFullAccess"
    "1"   = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  }
}

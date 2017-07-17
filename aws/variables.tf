variable "aws_terraform_profile" {
  description = "Terraform AWS profile"
}

variable "aws_terraform_region" {
  description = "AWS default region"
}

variable "modules_path" {
  #default = "github.com/aguamala/terraform-init/"
  default = "/home/gabo/github.com/aguamala/terraform-init/"
}

variable "modules_ref" {
  #default = "?ref=v0.6"
  default = ""
}

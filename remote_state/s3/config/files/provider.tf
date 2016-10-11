#--------------------------------------------------------------
# Configure provider
#--------------------------------------------------------------

provider "aws" {
    region = "${var.aws_terraform_region}"
    profile = "${var.aws_terraform_profile}"
}

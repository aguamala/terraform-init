#--------------------------------------------------------------
# Configure provider
#--------------------------------------------------------------

provider "aws" {
    region = "${var.aws_terraform_region}"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "us-west-1"
    region = "us-west-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "us-west-2"
    region = "us-west-2"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ca-central-1"
    region = "ca-central-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ap-south-1"
    region = "ap-south-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ap-northeast-1"
    region = "ap-northeast-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ap-northeast-2"
    region = "ap-northeast-2"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ap-southeast-1"
    region = "ap-southeast-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "ap-southeast-2"
    region = "ap-southeast-2"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "eu-central-1"
    region = "eu-central-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "eu-west-1"
    region = "eu-west-1"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "eu-west-2"
    region = "eu-west-2"
    profile = "${var.aws_terraform_profile}"
}

provider "aws" {
    alias = "sa-east-1"
    region = "sa-east-1"
    profile = "${var.aws_terraform_profile}"
}

#--------------------------------------------------------------
# S3 terraform state policy
#--------------------------------------------------------------
data "aws_iam_policy_document" "remote_state_config" {
    statement {
        sid = "1"
        actions = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
        ]
        resources = [
            "arn:aws:s3:::*",
        ]
    }
    statement {
        actions = [
            "s3:List*",
            "s3:Get*",
            "s3:PutObject",
        ]

        resources = [
            "arn:aws:s3:::${var.tf_state_bucket}${var.tf_state_path}",
            "arn:aws:s3:::${var.tf_state_bucket}${var.tf_state_path}*",
        ]
    }

}

resource "aws_iam_policy" "remote_state_config" {
    name = "${var.tf_state_name}_fullaccess_remote_state_s3_config"
    path = "/terraform/s3/"
    policy = "${data.aws_iam_policy_document.remote_state_config.json}"
}

data "aws_iam_policy_document" "readonly_remote_state_config" {
    statement {
        sid = "1"
        actions = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
        ]
        resources = [
            "arn:aws:s3:::*",
        ]
    }
    statement {
        actions = [
            "s3:List*",
            "s3:Get*",
        ]

        resources = [
            "arn:aws:s3:::${var.tf_state_bucket}${var.tf_state_path}",
            "arn:aws:s3:::${var.tf_state_bucket}${var.tf_state_path}/*",
        ]
    }

}

resource "aws_iam_policy" "readonly_remote_state_config" {
    name = "${var.tf_state_name}_readonlyaccess_remote_state_s3_config"
    path = "/readonly/terraform/s3/"
    policy = "${data.aws_iam_policy_document.readonly_remote_state_config.json}"
}

#--------------------------------------------------------------
# S3 remote state script
#--------------------------------------------------------------
resource "null_resource" "remote_state_config" {
    provisioner "local-exec" {
        command = "echo \"${data.template_file.remote_state_config.rendered}\" > ./${var.tf_state_path}remote-state-config.sh"
    }
}

data "template_file" "remote_state_config" {
    template = "${file("${path.module}/templates/remote_state_config_sh.tpl")}"

    vars {
        tf_state_bucket = "${var.tf_state_bucket}"
        tf_state_key = "${var.tf_state_path}${var.tf_state_name}.tfstate"
        tf_state_aws_region = "${var.tf_state_aws_region}"
        tf_state_aws_profile = "${var.tf_state_aws_profile}"
    }
}

resource "null_resource" "create_data_state_file" {
    provisioner "local-exec" {
        command = "echo \"${data.template_file.data_state_file.rendered}\" >> data-tfstate-files.tf"
    }

}

data "template_file" "data_state_file" {
    template = "${file("${path.module}/templates/data_tfstate_files.tpl")}"

    vars {
        tf_state_bucket = "${var.tf_state_bucket}"
        tf_state_name = "${var.tf_state_name}"
        tf_state_key = "${var.tf_state_path}${var.tf_state_name}.tfstate"
        tf_state_aws_region = "${var.tf_state_aws_region}"
        tf_state_aws_profile = "${var.tf_state_aws_profile}"
    }
}

#--------------------------------------------------------------
# Create terraform.tfvars
#--------------------------------------------------------------
resource "null_resource" "terraform_tfvars" {
    provisioner "local-exec" {
        command = "sh ${path.module}/scripts/init.sh ${var.tf_state_path}"
    }

    provisioner "local-exec" {
        command = "echo \"${data.template_file.terraform_tfvars.rendered}\" > ./${var.tf_state_path}terraform.tfvars"
    }
}

resource "null_resource" "providers_variables" {
    provisioner "local-exec" {
        command = "if [ ! -f ./${var.tf_state_path}variables.tf ]; then cp -p ${path.module}/files/variables.tf ./${var.tf_state_path}variables.tf; fi"
    }

    provisioner "local-exec" {
        command = "if [ ! -f ./${var.tf_state_path}provider.tf ]; then cp -p ${path.module}/files/provider.tf ./${var.tf_state_path}provider.tf; fi"
    }

    depends_on = ["null_resource.terraform_tfvars"]
}

data "template_file" "terraform_tfvars" {
    template = "${file("${path.module}/templates/terraform_tfvars.tpl")}"

    vars {
        terraform_tfvars_region = "${var.tf_state_aws_region}"
        terraform_tfvars_profile = "${var.tf_state_aws_profile}"
    }
}

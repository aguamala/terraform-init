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
            "arn:aws:s3:::${var.tf_state_bucket}/${var.tf_state_path}",
            "arn:aws:s3:::${var.tf_state_bucket}/${var.tf_state_path}*",
        ]
    }

}

resource "aws_iam_policy" "remote_state_config" {
    name = "${replace(var.tf_state_path, "/", "_")}fullaccess_remote_state_s3_config"
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
            "arn:aws:s3:::${var.tf_state_bucket}/${var.tf_state_path}",
            "arn:aws:s3:::${var.tf_state_bucket}/${var.tf_state_path}*",
        ]
    }

}

resource "aws_iam_policy" "readonly_remote_state_config" {
    name = "${replace(var.tf_state_path, "/", "_")}readonlyaccess_remote_state_s3_config"
    path = "/readonly/terraform/s3/"
    policy = "${data.aws_iam_policy_document.readonly_remote_state_config.json}"
}

#--------------------------------------------------------------
# S3 backend config
#--------------------------------------------------------------
resource "null_resource" "remote_state_config" {
    provisioner "local-exec" {
        command = "echo \"${data.template_file.remote_state_config.rendered}\" > backend_config.tf"
    }
}

data "template_file" "remote_state_config" {

    template = "${file("${path.module}/templates/backend_config.tpl")}"

    vars {
        tf_state_bucket = "${var.tf_state_bucket}"
        tf_state_key = "${var.tf_state_path}terraform.tfstate"
        tf_state_aws_region = "${var.tf_state_aws_region}"
        tf_state_aws_profile = "${var.tf_state_aws_profile}"
    }
}

resource "null_resource" "create_data_state_file" {
    provisioner "local-exec" {
        command = "echo \"${data.template_file.data_state_file.rendered}\" >> data_tfstate_files.tf"
    }

}

data "template_file" "data_state_file" {

    template = "${file("${path.module}/templates/data_tfstate_files.tpl")}"

    vars {
        tf_state_bucket = "${var.tf_state_bucket}"
        tf_state_key = "${var.tf_state_path}terraform.tfstate"
        tf_state_name =  "${replace(var.tf_state_path, "/", "_")}file"
        tf_state_aws_region = "${var.tf_state_aws_region}"
        tf_state_aws_profile = "${var.tf_state_aws_profile}"
    }
}

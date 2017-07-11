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
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_bucket}",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "${var.tfstate_path}*",
      ]
    }
  }

  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_bucket}/${var.tfstate_path}",
      "arn:aws:s3:::${var.tfstate_bucket}/${var.tfstate_path}*",
    ]
  }
}

resource "aws_iam_policy" "remote_state_config" {
  name   = "${var.tfstate_bucket}_${replace(var.tfstate_path, "/", "_")}fullaccess_remote_state_s3_config"
  policy = "${data.aws_iam_policy_document.remote_state_config.json}"
}

#--------------------------------------------------------------
# S3 backend config
#--------------------------------------------------------------
resource "null_resource" "remote_state_config" {
  provisioner "local-exec" {
    command = "echo \"${data.template_file.remote_state_config.rendered}\" > backend.tf"
  }
}

data "template_file" "remote_state_config" {
  template = "${file("${path.module}/templates/backend.tpl")}"

  vars {
    tfstate_bucket      = "${var.tfstate_bucket}"
    tfstate_key         = "${var.tfstate_path}terraform.tfstate"
    tfstate_aws_region  = "${var.tfstate_aws_region}"
    tfstate_aws_profile = "${var.tfstate_aws_profile}"
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
    tfstate_bucket      = "${var.tfstate_bucket}"
    tfstate_key         = "${var.tfstate_path}terraform.tfstate"
    tfstate_name        = "${replace(var.tfstate_path, "/", "_")}file"
    tfstate_aws_region  = "${var.tfstate_aws_region}"
    tfstate_aws_profile = "${var.tfstate_aws_profile}"
  }
}

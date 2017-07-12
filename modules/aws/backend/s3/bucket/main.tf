#--------------------------------------------------------------
# Create S3 bucket terraform state policy
#--------------------------------------------------------------
data "aws_iam_policy_document" "mod" {
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
      "s3:CreateBucket",
      "s3:Put*",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_iam_policy" "mod" {
  name   = "${var.terraform_backend_s3_bucket}_backend_s3_bucket"
  policy = "${data.aws_iam_policy_document.mod.json}"
}

resource "aws_iam_user_policy_attachment" "mod" {
  user       = "${var.aws_user_bucket_creator}"
  policy_arn = "${aws_iam_policy.mod.arn}"

  provisioner "local-exec" {
    command = "sleep 15"
  }
}

#--------------------------------------------------------------
# S3 terraform state bucket
#--------------------------------------------------------------

resource "aws_s3_bucket" "mod" {
  bucket = "${var.terraform_backend_s3_bucket}"
  acl    = "private"
  region = "${var.terraform_backend_s3_bucket_aws_region}"

  versioning {
    enabled = true
  }

  depends_on = ["aws_iam_user_policy_attachment.mod"]

  provisioner "local-exec" {
    command = "sleep 15"
  }
}

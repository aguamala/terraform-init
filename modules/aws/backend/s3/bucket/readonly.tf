#--------------------------------------------------------------
# S3 readonly_policy for terraform users
#--------------------------------------------------------------

data "aws_iam_policy_document" "readonly_policy" {
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
      "${aws_s3_bucket.mod.arn}",
      "${aws_s3_bucket.mod.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "readonly_policy" {
  name   = "${var.terraform_backend_s3_bucket}_backend_s3_bucket_readonlyaccess"
  policy = "${data.aws_iam_policy_document.readonly_policy.json}"
}

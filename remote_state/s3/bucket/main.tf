#--------------------------------------------------------------
# Create S3 bucket terraform state policy
#--------------------------------------------------------------
data "aws_iam_policy_document" "remote_state_bucket" {
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
            "s3:PutBucketVersioning",
            "s3:PutBucketAcl",
            "s3:PutObjectAcl",
            "s3:PutObjectVersionAcl",
        ]

        resources = [
            "arn:aws:s3:::*",
        ]
    }

}

resource "aws_iam_policy" "remote_state_bucket" {
    name = "${var.terraform_state_bucket}_remote_state_s3_bucket"
    path = "/terraform/"
    policy = "${data.aws_iam_policy_document.remote_state_bucket.json}"
}

resource "aws_iam_user_policy_attachment" "remote_state_bucket" {
    user = "${var.aws_user_bucket_creator}"
    policy_arn = "${aws_iam_policy.remote_state_bucket.arn}"

    provisioner "local-exec" {
        command = "sleep 15"
    }
}

#--------------------------------------------------------------
# S3 terraform state bucket
#--------------------------------------------------------------

resource "aws_s3_bucket" "remote_state_bucket" {
    bucket = "${var.terraform_state_bucket}"
    acl = "private"
    region = "${var.terraform_state_bucket_aws_region}"
    versioning {
        enabled = true
    }
    depends_on = ["aws_iam_user_policy_attachment.remote_state_bucket"]

    provisioner "local-exec" {
        command = "sleep 10"
    }
}

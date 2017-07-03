
resource "\"aws_iam_policy\"" "\"${environment}_networking_vpc\"" {
  name   = "\"${environment}_networking_vpc\""
  policy = "\"\$\{data.aws_iam_policy_document.${environment}_networking_vpc.json\}\""
}

data "\"aws_iam_policy_document\"" "\"${environment}_networking_vpc\"" {
  statement {
    sid = "\"1\""

    actions = [
      "\"vpc:*\"",
    ]

    condition {
      test     = "\"StringEquals\""
      variable = "\"ec2:Vpc\""

      values = [
        "\"arn:aws:ec2:region:account:vpc/\$\{module.${environment}_vpc.id\}\"",
      ]
    }

    resources = [
      "\"*\"",
    ]
  }
}

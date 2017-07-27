#-------------------------------------------------------------------
# AWSCodeCommit repository ${name}
#--------------------------------------------------------------------

resource "\"aws_codecommit_repository\"" "\"${name}\"" {
  repository_name = "\"${name}\""
  description     = "\"\""
}

output "\"${name}_repository_id\"" {
  value = ["\"\$\{aws_codecommit_repository.${name}.repository_id\}\""]
}

output "\"${name}_arn\"" {
  value = ["\"\$\{aws_codecommit_repository.${name}.arn}\""]
}

output "\"${name}_clone_url_http\"" {
  value = ["\"\$\{aws_codecommit_repository.${name}.clone_url_http}\""]
}

output "\"${name}_clone_url_ssh\"" {
  value = ["\"\$\{aws_codecommit_repository.${name}.clone_url_ssh\}\""]
}

#--------------------------------------------------------------------
# AWSCodeCommitPowerUser-${name} IAM policy attachment
#--------------------------------------------------------------------
data "\"aws_iam_policy_document\"" "\"AWSCodeCommitPowerUser-${name}\"" {
  statement {
    sid = "\"1\""

    actions = [
      "\"codecommit:BatchGetRepositories\"",
      "\"codecommit:CreateBranch\"",
      "\"codecommit:CreateRepository\"",
      "\"codecommit:DeleteBranch\"",
      "\"codecommit:Get*\"",
      "\"codecommit:GitPull\"",
      "\"codecommit:GitPush\"",
      "\"codecommit:List*\"",
      "\"codecommit:Put*\"",
      "\"codecommit:Test*\"",
      "\"codecommit:Update*\"",
    ]

    resources = [
      "\"\$\{aws_codecommit_repository.${name}.arn\}\"",
    ]
  }
}

resource "\"aws_iam_policy\"" "\"AWSCodeCommitPowerUser-${name}\"" {
  name        = "\"AWSCodeCommitPowerUser-${name}\""
  description = "\"\""
  policy      = "\"\$\{data.aws_iam_policy_document.AWSCodeCommitPowerUser-${name}.json\}\""
}

resource "\"aws_iam_policy_attachment\"" "\"AWSCodeCommitPowerUser-${name}\"" {
  name       = "\"AWSCodeCommitPowerUser-${name}-policy-attachment\""
  users      = []
  roles      = []
  groups     = []
  policy_arn = "\"\$\{aws_iam_policy.AWSCodeCommitPowerUser-${name}.arn\}\""
}

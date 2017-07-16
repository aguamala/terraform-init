#--------------------------------------------------------------
# Create initial terraform resources for a AWS service.
# This modules run locally to create a directory structure.
#--------------------------------------------------------------

#create group with a AWS managed policy attachment
module "\"iam_managed_policies_groups\"" {
  source        = "\"${modules_path}/modules/aws/templates${modules_ref}\""
  modules_path  = "\"\$\{var.modules_path\}\""
  modules_ref   = "\"\$\{var.modules_ref\}\""
  service       = "\"IAM\""
  group         = true
  policies = [
      "\"Billing\"",
      "\"AdministratorAccess\"",
      "\"DatabaseAdministrator\"",
      "\"SystemAdministrator\"",
      "\"NetworkAdministrator\"",
      "\"AmazonGlacierReadOnlyAccess\"",
      "\"AutoScalingConsoleReadOnlyAccess\"",
      "\"AmazonEC2ContainerRegistryReadOnly\"",
      "\"AmazonEC2ReadOnlyAccess\"",
      "\"AmazonVPCReadOnlyAccess\"",
      "\"CloudWatchEventsReadOnlyAccess\"",
      "\"ReadOnlyAccess\"",
      "\"AmazonSESReadOnlyAccess\"",
      "\"AmazonElasticFileSystemReadOnlyAccess\"",
      "\"AmazonRoute53ReadOnlyAccess\"",
      "\"AmazonDynamoDBReadOnlyAccess\"",
      "\"AmazonSNSReadOnlyAccess\"",
      "\"AmazonS3ReadOnlyAccess\"",
      "\"CloudWatchLogsReadOnlyAccess\"",
      "\"AWSCloudTrailReadOnlyAccess\"",
      "\"AmazonWorkMailReadOnlyAccess\"",
      "\"ResourceGroupsandTagEditorReadOnlyAccess\"",
      "\"IAMReadOnlyAccess\"",
      "\"AmazonRDSReadOnlyAccess\"",
      "\"CloudWatchReadOnlyAccess\"",
      "\"ServiceCatalogAdminReadOnlyAccess\"",
      "\"AWSCodeCommitReadOnly\"",
      "\"AWSDirectoryServiceReadOnlyAccess\"",
      "\"AmazonRDSFullAccess\"",
      "\"AmazonEC2FullAccess\"",
      "\"IAMFullAccess\"",
      "\"AutoScalingFullAccess\"",
      "\"AmazonEC2ContainerRegistryFullAccess\"",
      "\"AmazonS3FullAccess\"",
      "\"CloudWatchFullAccess\"",
      "\"ServiceCatalogAdminFullAccess\"",
      "\"AmazonDynamoDBFullAccess\"",
      "\"AWSCloudTrailFullAccess\"",
      "\"AutoScalingConsoleFullAccess\"",
      "\"AmazonSESFullAccess\"",
      "\"CloudWatchLogsFullAccess\"",
      "\"AmazonEC2ContainerServiceFullAccess\"",
      "\"AmazonVPCFullAccess\"",
      "\"ServiceCatalogEndUserFullAccess\"",
      "\"AmazonElasticFileSystemFullAccess\"",
      "\"ResourceGroupsandTagEditorFullAccess\"",
      "\"AmazonGlacierFullAccess\"",
      "\"AmazonWorkMailFullAccess\"",
      "\"AmazonSNSFullAccess\"",
      "\"AmazonRoute53FullAccess\"",
      "\"CloudWatchEventsFullAccess\"",
      "\"AWSCodeCommitFullAccess\"",
      "\"AWSDirectoryServiceFullAccess\"",
  ]
}

#create AWS managed policy attachment
module "\"iam_managed_policies\"" {
  source = "\"${modules_path}/modules/aws/templates${modules_ref}\""
  modules_path  = "\"\$\{var.modules_path\}\""
  modules_ref   = "\"\$\{var.modules_ref\}\""
  service = "\"IAM\""
  policies = []
}

#create group with a custom policy attachment
module "\"iam_custom_groups\"" {
  source = "\"${modules_path}/modules/aws/templates${modules_ref}\""
  modules_path  = "\"\$\{var.modules_path\}\""
  modules_ref   = "\"\$\{var.modules_ref\}\""
  service  = "\"IAM\""
  group    = true
  custom   = true
  policies = ["\"TerraformBucketReadOnlyAccess\""]
}

#create custom policy attachment
module "\"iam_custom_policies\"" {
  source = "\"${modules_path}/modules/aws/templates${modules_ref}\""
  modules_path  = "\"\$\{var.modules_path\}\""
  modules_ref   = "\"\$\{var.modules_ref\}\""
  service  = "\"IAM\""
  custom   = true
  policies = []
}

#module "\"storage_s3_templates\"" {
#  source = "\"${modules_path}/modules/aws/templates${modules_ref}\""
#  modules_path  = "\"\$\{var.modules_path\}\""
#  modules_ref   = "\"\$\{var.modules_ref\}\""
#  service = "\"S3\""
#}

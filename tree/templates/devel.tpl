#--------------------------------------------------------------
# Create initial terraform resources for a AWS service with a
# given environment.
# This modules run locally to create a directory structure.
#--------------------------------------------------------------
module "\"devel_networking_vpc_templates\"" {
  source = "\"${modules_path}/modules/aws/templates${modules_ref}\""
  modules_path  = "\"\$\{var.modules_path\}\""
  modules_ref   = "\"\$\{var.modules_ref\}\""
  service = "\"networking_vpc\""
  domain  = "\"devel\""
}

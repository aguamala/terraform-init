resource "\"null_resource\"" "\"links\"" {
      provisioner "\"local-exec\"" {
          command = "\"ln -s ../../data_tfstate_files.tf data_tfstate_files.tf\""
      }

      provisioner "\"local-exec\"" {
          command = "\"ln -s ../../variables.tf variables.tf\""
      }

      provisioner "\"local-exec\"" {
          command = "\"ln -s ../../provider.tf provider.tf\""
      }

      provisioner "\"local-exec\"" {
          command = "\"ln -s ../../terraform_tfvars.tf terraform_tfvars.tf\""
      }
}

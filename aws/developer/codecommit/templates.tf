#--------------------------------------------------------------
# codecommit repositories_templates
#--------------------------------------------------------------
data "template_file" "repositories_templates" {
  count    = "${length(var.repositories_templates)}"
  template = "${file("templates/repository.tpl")}"

  vars {
    name = "${var.repositories_templates[count.index]}"
  }
}

resource "null_resource" "repositories_templates" {
  count = "${length(var.repositories_templates)}"

  provisioner "local-exec" {
    command = "if [ ! -f ./${var.repositories_templates[count.index]}.tf ]; then echo \"${data.template_file.repositories_templates.*.rendered[count.index]}\" > ./${var.repositories_templates[count.index]}.tf; fi"
  }

  triggers {
    repos = "${join(",", var.repositories_templates)}"
  }
}

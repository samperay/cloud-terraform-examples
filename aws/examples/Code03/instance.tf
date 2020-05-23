provider "aws" {
  profile = "default"
  region     = "${var.aws_region}"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami           = "${lookup(var.amiid, var.aws_region)}"

  # Interpolation vars 
  count = "${var.target_env == "dev" ? 1 : 0}"

}

# Terraform templates to attach policy dynamic using data templates

data "template_file" "webserver_policy_template" {
  template = "${file("${path.module}/policy.tpl")}"
  vars = {
    arn = "${ aws_instance.webserver[0].arn }"
  }
}

output "webserver-instanceid" {
  value = "${ aws_instance.webserver[0].id }"
}

output "web_server_policy_output" {
  value = "${ data.template_file.webserver_policy_template.rendered }"
}
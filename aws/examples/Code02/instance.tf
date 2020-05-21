provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key =  "${var.aws_secret_key}"
  region     =  "${var.aws_region}"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "${lookup(var.amiid, var.aws_region)}"

  # Interpolation vars 
  count = "${var.target_env == "dev" ? 0 : 2}"

}
# Ensure you would select target_env = prod while you are applying else terraform would 
# throw error because of the index issue

output "webserver-public-ip-1" {
  value = "${ aws_instance.webserver.*.public_ip[0]}"
}

output "webip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

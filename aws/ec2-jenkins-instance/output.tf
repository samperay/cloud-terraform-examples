output "jenkins-ip" {
  value = ["${aws_instance.jenkins-instance.*.public_ip}"]
}
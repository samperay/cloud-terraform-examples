resource "aws_instance" "private-instance" {
   ami =  "${lookup(var.AMIS, var.AWS_REGION)}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.mykey.key_name}"
   security_groups = "${aws_security_group.bastion-allow-private.id}"
   subnet_id = ["${aws_subnet.bastion-private-1.cidr_block}"]

   tags = {
       Name = "Private-instance"
   }
}
// creates a simple test instance in default VPC

resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.mykey.key_name}"
    count = 1
    user_data = "#!/bin/bash\nsudo yum install -y httpd\nsudo service httpd start\ncd /var/www/html\nsudo chmod 777 /var/www/html\nsudo echo '<html><h1>Hello, Welcome to AWS test Instance</h1></html>' >index.html"

    tags = {
        Name = "example"
        Team = "Dev"
    }
}
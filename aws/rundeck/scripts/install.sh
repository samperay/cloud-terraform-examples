#!/bin/bash
# install rundeck on the host

# update machine to latest version
sudo yum install -y

# insyall opensource rundeck
sudo rpm -Uvh http://repo.rundeck.org/latest.rpm
sudo yum install rundeck java -y
sudo yum update rundeck -y
sudo service rundeckd start
sudo systemctl enabled start
echo 'rundeck installed at running at location http://localhost:4440'

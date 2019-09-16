#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo systemctl start apache2 
curl http://169.254.169.254/latest/meta-data/public-ipv4 > index.html 
sudo mv index.html /var/www/html/index.html
#!/bin/bash
sudo dnf update -y
sudo dnf install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo '<center><h1>Projeto 1</h1></center>' > /var/www/html/index.html
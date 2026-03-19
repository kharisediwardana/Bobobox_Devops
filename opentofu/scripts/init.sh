#!/bin/bash

apt update -y

apt install -y docker.io docker-compose-v2
systemctl start docker
systemctl enable docker

apt install -y nginx

echo "Hello, OpenTofu!" > /var/www/html/index.html

systemctl start nginx
systemctl enable nginx

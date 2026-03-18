#!/bin/bash

yum install -y nginx
systemctl enable nginx
systemctl start nginx

echo "Hello, OpenTofu!" > /usr/share/nginx/html/index.html
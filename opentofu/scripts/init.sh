#!/bin/bash

apt update -y

apt install -y docker.io docker-compose-v2
systemctl start docker
systemctl enable docker

apt install -y nginx

# reverse proxy to forward port 80 → 3000
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF

systemctl restart nginx
systemctl enable nginx

# Bobobox_Devops

a take home assigment of Bobobox Devops Recruitment process

# health_check

1. give permission to run the script

chmod +x health_check.sh

2. running the script

./health_check.sh <host> [port(default:80)]

# Docker

1. Build image
   docker build -t app .

2. Run container
   docker run -p 3000:3000 app

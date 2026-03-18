# Bobobox_Devops

a take home assigment of Bobobox Devops Recruitment process

# Prerequisites

- Akun AWS
- Access Key & Secret Key
- Internet connection

# Open tofu (Mac)

1. install opentofu with brew
   brew install opentofu

2. verify
   tofu version

# health_check

1. give permission to run the script
   chmod +x health_check.sh

2. running the script
   ./health_check.sh <host> [port(default:80)]

# AWS CLI

1. Install AWS CLI on Mac
   brew install awscli

2. Verify
   aws --version

# Configure AWS Credential

- aws configure
- Input :
  AWS Access Key ID: <your-key>
  AWS Secret Access Key: <your-secret>
  Region: ap-southeast-1
  Output format: json

# Docker

Running docker compose : docker compose up -d --build
Local : http://localhost:3000

stop : docker compose down

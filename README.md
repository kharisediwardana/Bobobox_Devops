# Bobobox DevOps — Infrastructure Implementation Guide

## 1. Architecture Diagram

### System Topology

Developer
|
| - code push (main branch)
|
Github Repository
| - Github Action
Build & Push Image - Dockerhub
|
Deploy
|
| - Init webserver - Nginx
|
AWS cloud
| - Security Group - Inbound: 80 (HTTP), 22 (SSH)
EC 2 Instance (t2.micro)

### CI/CD Flow

git push (main branch)
│
▼
GitHub Actions: "Build & Push Docker Compose App"
│ - Checkout code
│ - Login to Docker Hub
│ - docker compose build
│ - docker push kewtz9/bobobox-app:latest
│
▼ (on success)
GitHub Actions: "Deploy App"
│ - SSH into EC2
│ - cd ~/app
│ - docker compose pull
│ - docker compose up -d
│
▼
App is live on EC2 public IP

# 2 - Deployment strategies

Deployment is automated through github action with two workflows :

## Build & push

- Trigger after push to main branch
- Build the docker image using multi-stage
- Push to dockerhub

## Deploy

- Trigger after Build & Push workflow succeed
- SSH into EC2 Instance using latest image then restarts the container

## Rollback and recovery

- Rollback : docker image store on docker hub with tag version
- Recovery : opentofu as provisioning and secret management on github

### Reason

- multi stage build image : make process more lighter and faster
- multi workflows : prevent deploying broken images
- Use docker registry : Easy to recovery and rollnback

## 3 - Infrastucture provisioning

The EC2 Instance - AWS is provisioned using opentofu

### Reason :

- Provider, region, instance type choose based on cost, application usage and size

## 4 - Security

### Secret Management

- docker password, SSH key, SSH host, SSH user, stored on github secret management

## Firewall

- Security Group declared only open to port 80(HTTP), and 22 (SSH)

### Reason:

- prevent credential leak, easier to managed and audit.

## Observability

- Health check scripts

# SETUP

# Prerequisites

- AWS Account
- Access Key & Secret Key
- Internet connection

# Open tofu (Mac)

### Bash

cd opentofu
tofu init # Download AWS provider
tofu plan # Preview changes
tofu apply # Create infrastructure
tofu destroy # Tear down when done

# health_check

chmod +x health_check.sh. # Give permission
./health_check.sh <host> [port(default:80)] # running script

# AWS CLI

brew install awscli # Install AWS CLI on Mac
aws --version. # Verify version

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

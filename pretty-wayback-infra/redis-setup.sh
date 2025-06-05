#!/bin/bash
sudo apt update
sudo apt install -y docker.io docker-compose

cat <<EOF > docker-compose.yml
version: '3'
services:
  redis:
    image: redis:7
    ports:
      - "6379:6379"
EOF

docker compose up -d

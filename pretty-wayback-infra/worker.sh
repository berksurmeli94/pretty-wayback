#!/bin/bash
sudo apt update
sudo apt install -y docker.io docker-compose

echo "REDIS_URL=redis://${redis_private_ip}:6379/0" >> .env
echo "ELASTIC_URL=http://${elastic_private_ip}:9200" >> .env

cd worker-app

docker compose up -d

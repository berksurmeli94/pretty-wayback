#!/bin/bash
sudo apt update
sudo apt install -y docker.io docker-compose

cat <<EOF > docker-compose.yml
version: '3'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ports:
      - "9200:9200"
EOF

docker compose up -d

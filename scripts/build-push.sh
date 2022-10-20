#!/usr/bin/env zsh

set -e
set -x

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USER" --password-stdin

docker buildx build --platform linux/amd64 --push . \
  --tag=kfelts910/node18-frontend:18 \
  --tag=kfelts910/node18-frontend:latest

docker buildx build --platform linux/arm64 --push . \
  --tag=kfelts910/node18-frontend:18 \
  --tag=kfelts910/node18-frontend:latest
#!/usr/bin/env zsh

set -e
set -x

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USER" --password-stdin

docker buildx build --platform linux/amd64 --push . \
  --tag=antonapetrov/node-frontend:14 \
  --tag=antonapetrov/node-frontend:latest

docker buildx build --platform linux/arm64 --push . \
  --tag=antonapetrov/node-frontend:14 \
  --tag=antonapetrov/node-frontend:latest
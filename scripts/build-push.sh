#!/usr/bin/env bash

set -e
set -x

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin

docker build -t antonapetrov/node-frontend:14 .

docker build -t antonapetrov/node-frontend:latest .

docker push antonapetrov/node-frontend:14

docker push antonapetrov/node-frontend:latest

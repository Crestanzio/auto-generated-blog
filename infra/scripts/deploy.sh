#!/bin/bash
set -e

################################################################################
#                                                                              #
#                                   VARIABLES                                  #
#                                                                              #
################################################################################

FRONTEND="$ECR_URI/frontend:latest"
BACKEND="$ECR_URI/backend:latest"
NETWORK="blog"

################################################################################
#                                                                              #
#                                     MAIN                                     #
#                                                                              #
################################################################################

# create docker network
if [ -z "$(docker network ls --filter name=$NETWORK -q)" ]; then
    docker network create $NETWORK
    echo "Created Docker network: $NETWORK"
fi

# login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

# get last images
docker pull $BACKEND
docker pull $FRONTEND

# start docker images
docker-compose -f docker-compose.yml down
docker-compose -f docker-compose.yml up -d
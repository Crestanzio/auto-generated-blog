#!/bin/bash

set -e # exit on error
set -f # disable globbing

################################################################################
#                                                                              #
#                                   VARIABLES                                  #
#                                                                              #
################################################################################

# get variables from codebuild
CODEBUILD_ENV=$(aws codebuild batch-get-projects --names "blog-codebuild" --query "projects[0].environment.environmentVariables")

# create temp .env for docker (pattern resolve 'node-cron' issue #482)
echo "$CODEBUILD_ENV" | jq -r '.[] | "\(.name)=\(.value)"' > .env

# make valid bash variables eg. export variable="value"
eval "$(awk -F= '{print "export "$1"=\""$2"\""}' .env)"

export IMAGE_TAG="latest"
export FRONTEND="$ECR_URI/frontend"
export BACKEND="$ECR_URI/backend"

################################################################################
#                                                                              #
#                                     MAIN                                     #
#                                                                              #
################################################################################

# login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

# remove old images
docker rm -f backend frontend 2>/dev/null || true

# get last images
docker pull $BACKEND
docker pull $FRONTEND

# run images
docker run -d --name backend  --env-file .env -e PORT=$BACKEND_PORT  -e HOST=$BACKEND_HOST  -p $BACKEND_PORT:$BACKEND_PORT   $BACKEND
docker run -d --name frontend --env-file .env -e PORT=$FRONTEND_PORT -e HOST=$FRONTEND_HOST -p $FRONTEND_PORT:$FRONTEND_PORT $FRONTEND

# remove env variables
rm .env
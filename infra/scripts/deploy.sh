#!/bin/bash
set -e

################################################################################
#                                                                              #
#                                   VARIABLES                                  #
#                                                                              #
################################################################################

# get variables from codebuild
eval "$(aws codebuild batch-get-projects --names "blog-codebuild" \
  --query "projects[0].environment.environmentVariables" \
  --output json | jq -r '.[] | "\(.name)=\"\(.value)\""' )"

FRONTEND="$ECR_URI/frontend:latest"
BACKEND="$ECR_URI/backend:latest"

################################################################################
#                                                                              #
#                                     MAIN                                     #
#                                                                              #
################################################################################

# login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

# get last images
docker pull $BACKEND
docker pull $FRONTEND

# start docker images
docker compose -f docker-compose.yml down
docker compose -f docker-compose.yml up -d
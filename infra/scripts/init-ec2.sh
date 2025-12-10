#!/bin/bash
set -e

################################################################################
#                                                                              #
#                                   VARIABLES                                  #
#                                                                              #
################################################################################

REPO_URL="https://github.com/crestanzio/auto-generated-blog.git"
REPO_DIR="$HOME/blog"

################################################################################
#                                                                              #
#                                 DEPENDENCIES                                 #
#                                                                              #
################################################################################

echo "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "Installing required packages..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release \
    unzip \
    git

echo "Installing Docker..."
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER
fi

echo "Installing Docker Compose..."
if ! command -v docker-compose &> /dev/null
then
    DOCKER_COMPOSE_VERSION="2.20.2"
    sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo "Installing AWS CLI..."
if ! command -v aws &> /dev/null
then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
fi

################################################################################
#                                                                              #
#                                 DEPENDENCIES                                 #
#                                                                              #
################################################################################

if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning repo into $REPO_DIR..."
    git clone $REPO_URL $REPO_DIR
else
    echo "Repo already exists at $REPO_DIR. Pulling latest changes..."
    cd $REPO_DIR
    git pull
fi

echo "EC2 instance initialized successfully."
echo To deploy the app, run the command: 'cd $REPO_DIR && ./infra/scripts/deploy.sh'"
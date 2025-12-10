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
sudo apt update && sudo apt upgrade -y

################################################################################
#                                                                              #
#                                    DOCKER                                    #
#                                                                              #
################################################################################

if ! command -v docker &> /dev/null
then
  echo "Installing Docker..."

  # get key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  
  # write the signed
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
       https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
       sudo tee /etc/apt/sources.list.d/docker.list.distUpgrade
  
  sudo apt install docker-ce docker-ce-cli containerd.io
  
  # give permissions
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo systemctl start docker
fi

################################################################################
#                                                                              #
#                                    AWS CLI                                   #
#                                                                              #
################################################################################

if ! command -v aws &> /dev/null
then
  echo "Installing AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  python3 -m zipfile -e awscliv2.zip ./aws
  sudo ./aws/install
  rm -rf aws awscliv2.zip
fi

################################################################################
#                                                                              #
#                                     REPO                                     #
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
#!/bin/bash
set -e

################################################################################
#                                                                              #
#                                   VARIABLES                                  #
#                                                                              #
################################################################################

REPO_URL="https://github.com/crestanzio/auto-generated-blog.git"
PROJECT="blog"
REPO_DIR="$HOME/$PROJECT"

################################################################################
#                                                                              #
#                                 DEPENDENCIES                                 #
#                                                                              #
################################################################################

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

################################################################################
#                                                                              #
#                                    AWS CLI                                   #
#                                                                              #
################################################################################

if ! which aws &> /dev/null; then
  echo "Installing AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  
  sudo apt install -y -qq unzip
  unzip -q awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
fi

################################################################################
#                                                                              #
#                                    DOCKER                                    #
#                                                                              #
################################################################################

if ! which docker &> /dev/null; then
  file="/etc/apt/sources.list.d/docker.sources"
  ubuntu=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
  
  echo "Installing Docker..."

  # get key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  
  # create source file
  echo "Types: deb"                                     | sudo tee -a $file > /dev/null
  echo "URIs: https://download.docker.com/linux/ubuntu" | sudo tee -a $file > /dev/null
  echo "Suites: $ubuntu"                                | sudo tee -a $file > /dev/null
  echo "Components: stable"                             | sudo tee -a $file > /dev/null
  echo "Signed-By: /etc/apt/keyrings/docker.gpg"        | sudo tee -a $file > /dev/null

  # install docker packages
  sudo apt update -y
  sudo apt install -y docker-ce docker-ce-cli containerd.io

  # start service
  sudo systemctl enable --now docker
  
  # give sudo permissions
  sudo groupadd -f docker
  sudo usermod -aG docker $USER
fi

echo "EC2 instance initialized successfully."
#!/bin/bash

check_command() {
  type "$1" &> /dev/null
}

if check_command curl; then
  echo "curl is already installed."
else
  echo "curl is not installed. Installing..."
  if ! sudo apt-get install -y curl < "/dev/null"; then
    echo "Failed to install curl. Aborting."
    exit 1
  fi
fi

profile_file="$HOME/.bash_profile"
if [ -e "$profile_file" ]; then
  . "$profile_file"
fi

sleep 1

cd "$HOME"
sudo mkdir -m 0755 -p /etc/apt/keyrings
sudo rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod 0644 /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -qy
sudo apt-get upgrade -qy
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker --version
sudo docker pull nillion/retailtoken-accuser:v1.0.0

accuser_dir="$HOME/nillion/accuser"
mkdir -p "$accuser_dir"
sudo docker run -v "$accuser_dir:/var/tmp" nillion/retailtoken-accuser:v1.0.0 initialise

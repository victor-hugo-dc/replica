#!/bin/bash
set -e

# 1. Update apt and install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# 2. Add Docker’s official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 3. Add Docker’s official repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Update apt again (this is necessary after adding a new repository)
sudo apt-get update

# 5. Install Docker Engine and Compose plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. (Optional) Add your user to the docker group (so you don't need sudo)
# sudo groupadd docker || true
sudo usermod -aG docker $USER

# 7. Print Docker version to verify installation
docker --version
docker compose version

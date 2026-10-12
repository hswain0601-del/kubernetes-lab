#!/bin/bash

# Shell script to install docker /k8s on minikube / helm 
# Pre-flight Check: Validate Hardware Requirements (Minikube requires >= 2 vCPUs and >= 1800MB RAM)
MIN_CPUS=2
MIN_MEM_MB=1800

TOTAL_CPUS=$(nproc)
TOTAL_MEM_MB=$(free -m | awk '/^Mem:/{print $2}')

echo "========================================="
echo "Checking System Requirements for Minikube"
echo "Detected CPUs: $TOTAL_CPUS (Required: at least $MIN_CPUS)"
echo "Detected RAM:  ${TOTAL_MEM_MB}MB (Required: at least ${MIN_MEM_MB}MB)"
echo "========================================="

if [ "$TOTAL_CPUS" -lt "$MIN_CPUS" ] || [ "$TOTAL_MEM_MB" -lt "$MIN_MEM_MB" ]; then
    echo "❌ ERROR: Insufficient resources to run Minikube!"
    echo "   Minikube requires at least $MIN_CPUS vCPUs and ${MIN_MEM_MB}MB RAM."
    echo "   On AWS EC2, upgrade to at least 't3.medium' or 't2.medium'."
    exit 1
fi

echo "✅ System requirements met. Proceeding with installation..."

# Update package list
sudo apt-get update

# Install Docker prerequisites
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create docker group if it doesn't exist
sudo groupadd docker 2>/dev/null || true

# Add current user to the docker group
sudo usermod -aG docker $USER

# Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f get_helm.sh

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl kubectl.sha256

# Verify kubectl version
kubectl version --client

# Start Minikube using the docker group
echo "Starting Minikube..."
sg docker -c "minikube start"

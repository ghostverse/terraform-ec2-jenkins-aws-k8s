#!/bin/bash

# Update package list
sudo apt update && sudo apt upgrade -y

# Install Java 17 (OpenJDK)
sudo apt install openjdk-17-jdk -y

# Install git, nodejs, npm
sudo apt install git nodejs npm curl unzip jq -y

# Install Maven
sudo apt install maven -y

# Install Jenkins (Ubuntu)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y

# Change Jenkins port (optional)
sudo sed -i 's/HTTP_PORT=.*/HTTP_PORT=8081/' /etc/default/jenkins

sudo systemctl daemon-reexec
sudo systemctl restart jenkins
sudo systemctl status jenkins

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install ZAP
wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2_14_0_unix.sh
chmod +x ZAP_2_14_0_unix.sh
./ZAP_2_14_0_unix.sh -q

# Install kubectl
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install Docker
sudo apt install docker.io -y
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
newgrp docker

sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

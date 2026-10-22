#!/bin/bash
# TP6 - Installation de Docker et Terraform sur la VM control (a lancer avec sudo)
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get install -y -q docker.io gnupg wget lsb-release
usermod -aG docker devops
if [ ! -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
  wget -qO- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
fi
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  > /etc/apt/sources.list.d/hashicorp.list
apt-get update -q
apt-get install -y -q terraform
grep -q devopslab /etc/hosts || echo "192.168.56.81 devopslab" >> /etc/hosts
terraform version

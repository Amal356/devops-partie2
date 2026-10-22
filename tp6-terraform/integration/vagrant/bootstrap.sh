#!/bin/bash
# Preparation commune : utilisateur devops (sudo), SSH par mot de passe (lab), /etc/hosts
set -e
ROLE="$1"

id devops &>/dev/null || useradd -m -s /bin/bash -G sudo devops
echo 'devops:devops' | chpasswd

# Lab uniquement : autoriser l'authentification SSH par mot de passe (Partie 0 du TP4 avec -k)
echo "PasswordAuthentication yes" > /etc/ssh/sshd_config.d/00-lab.conf
systemctl restart ssh

grep -q webserver /etc/hosts || cat >> /etc/hosts <<'HOSTS'
192.168.56.80 control
192.168.56.81 webserver
192.168.56.82 ftpserver
HOSTS

if [ "$ROLE" = "control" ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -q
  apt-get install -y -q ansible sshpass tree
fi
echo "bootstrap $ROLE : OK"

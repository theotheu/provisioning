#!/usr/bin/env bash

sudo apt-get -y install software-properties-common aptitude git python-simplejson
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

# Create user non-interactively
# ---> Proxmox template 16.04 is complaining about missing users <---
# Replace ___PASSWORD___ and ___USERNAME___ with actual values
# useradd -m -p `perl -e 'printf("%s\n", crypt($ARGV[0], "password"))' "___PASSWORD___"` -s /bin/bash ___USERNAME___

cd ~
mkdir -p code
cd code
git clone https://github.com/theotheu/ebig-provisioning.git
cd ebig-provisioning/ansible

# Issue with setting locales
# @see issue https://github.com/ansible/ansible/issues/10698 
# Beste workaround is to not accept variables from the client 
sed -i 's/AcceptEnv/# AcceptEnv/' /etc/ssh/sshd_config
service ssh restart

ansible-playbook local.yml  --connection=local
exit 0
#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive  

sudo apt-get -y install software-properties-common aptitude git 
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

cd ~
mkdir -p code
cd code
git clone https://github.com/theotheu/provisioning.git
# just to make sure that latest commits are used
cd provisioning
git fetch --all && git reset --hard && git pull origin master
cd ansible

# Issue with setting locales
# @see issue https://github.com/ansible/ansible/issues/10698 
# Best workaround is to not accept variables from the client 
sudo sed -i 's/AcceptEnv/# AcceptEnv/' /etc/ssh/sshd_config
sudo service ssh restart

# @see https://stackoverflow.com/questions/43791040/suppress-ansible-ad-hoc-warning
ANSIBLE_PYTHON_INTERPRETER=auto_silent

ansible-playbook local.yml  --connection=local -vvvv
exit 0

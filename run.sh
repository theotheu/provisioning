#!/usr/bin/env bash

echo "######################################################################"
export DB_ROOT_PWD=`cat /tmp/my`
echo "#"
echo "# DB_ROOT_PWD=${DB_ROOT_PWD}"
echo "#"
echo "######################################################################"


DEBIAN_FRONTEND=noninteractive  

sudo apt-get -y install software-properties-common aptitude git 
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible


# echo "Installing pyenv for using multiple versions of Python"
# sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
# curl https://pyenv.run | bash


cd ~
mkdir -p code
cd code
git clone https://github.com/theotheu/provisioning.git
# just to make sure that latest commits are used
cd provisioning
git fetch --all && git reset --hard && git pull origin master
cd ansible

echo "######################################################################"
echo "#"
echo "# Replacing variables in Ansible files."
echo "#"
echo "######################################################################"

grep -rlZ '"{{ db_root_pwd }}"' * | xargs -0 sed -i "s/\"{{ db_root_pwd }}\"/${DB_ROOT_PWD}/g"
grep -rlZ '{{ db_root_pwd }}' * | xargs -0 sed -i "s/{{ db_root_pwd }}/${DB_ROOT_PWD}/g"

exit 1

# Issue with setting locales
# @see issue https://github.com/ansible/ansible/issues/10698 
# Best workaround is to not accept variables from the client 
sudo sed -i 's/AcceptEnv/# AcceptEnv/' /etc/ssh/sshd_config
sudo service ssh restart

# @see https://stackoverflow.com/questions/43791040/suppress-ansible-ad-hoc-warning
ANSIBLE_PYTHON_INTERPRETER=auto_silent

ansible-playbook local.yml --connection=local -vvvv --extra-vars "DB_ROOT_PWD=${DB_ROOT_PWD} db_root_pwd=${DB_ROOT_PWD}"

rm -fr /tmp/my
exit 0

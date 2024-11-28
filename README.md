
# Provisioning with Ansible

The vagrant directory is for local test purposes.

If you want to test local, start with vagrant. Then continue with ansible.

See README in vagrant directory and ansible directory.

## One-liner for ordinary user to run on new machine. The script asks for a root password. 


`echo "my_password">/tmp/passwd && wget -qO- https://raw.githubusercontent.com/theotheu/provisioning/master/run.sh | bash`


It is tested on Ubuntu 22.04. 

See branches for 14.04, 16.04, 18.04, or 20.04.

Iptables is applied in strict mode. See `/root/iptables.strict`. Use `/root/iptables.minial` for unsecure operations (not recommended).

Running a specific task, eg. hardening, run:
```
cd ~/code/provisioning/ansible
sudo ansible-playbook hardening.yml --connection=local -i hosts -vvvv
```


# Ansible provisioning

The vagrant directory is for local test purposes.

If you want to test local, start with vagrant. Then continue with ansible.

See README in vagrant directory and ansible directory.

## One-liner for ordinary user to run on new machine. The script asks for a root password. 


`wget -qO- https://raw.githubusercontent.com/theotheu/provisioning/master/run.sh | bash`


It is tested on Ubuntu 16.04, also works on Ubuntu 14.04.

Iptables is applied in strict mode. See `/root/iptables.strict`. Use `/root/iptables.minial` for unsecure operations (not recommended).



# Requirements

## Virtualbox
[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

## Vagrant
[https://www.vagrantup.com/](https://www.vagrantup.com/)

## Ansible
[http://docs.ansible.com/intro_installation.html](http://docs.ansible.com/intro_installation.html)

Installation steps for Mac OS X
- Install Xcode
- ```sudo easy_install pip```
- ```sudo pip install ansible --quiet```

## Security
Copy the content of the local laptop ```cat ~/.ssh/id_rsa.pub``` to the remote server file ```/root/.ssh/authorized_keys```

Set privileges
- `chmod 0700 /root/.ssh`
- `chmod 0600 /root/.ssh/authorized_keys`

Make sure root user has access. You probably need to change the file `/etc/ssh/sshd_config` and set `PermitRootLogin` to `yes`.

## Configure 
- Copy file ```group_vars/all.local``` to ```group_vars/all``` and modify the variables.
- Configure the ```hosts``` file.


# Provision machine

Run installation with ansible from this directory
```ansible-playbook -i hosts site.yml```

This will run the common, users and hardening package.


# Documentation

## Common
With common is the base configuration of the machine set with date, locales and a few programmes.

The packages for Apache, MySQL and PHP LAMP development are installed.

The packages for Node.js and MongoDb for MEAN development are installed.

For Java addicts are the packages installed as wel.

Install the *packages* with ansible from this directory
```ansible-playbook -i hosts packages.yml -vvvv```

## Users
With users are two users installed.

One of them is the `webdev` user. The other is a user you have to define. This can be the username you use on a build server or test server.

The users will have sudo rights.

Install *users* with ansible from this directory
```ansible-playbook -i hosts users.yml -vvvv```

## Hardening
With the hardening, your machine will have a protection against attacks.

The following configuration is applied:
- Check for rootkits with [http://rkhunter.sourceforge.net/](rkhunter) and [http://rootkit.nl/projects/rootkit_hunter.html](rootkit)
- Protect su by limiting access only to admin group
- Prevent IP spoofing
- Prevent root log in
- Disable Open DNS Recursion and Remove Version Info  - BIND DNS Server
- iptables
- fail2ban

Consider this hardening in your local environment. The production server will have hardening.

Configure *hardening* with ansible from this directory
```ansible-playbook -i hosts hardening.yml -vvvv```


Installation of vagrant
-----------------------
- Read https://joachim8675309.medium.com/vagrant-with-macbook-mx-arm64-0f590fd7e48a
- Go to http://www.vagrantup.com/downloads.html and select vagrant for your platform


Initialization
--------------
`git clone https://github.com/theotheu/provisoning`

Checkout the ubuntu version, eg `git checkout 18.04`

`cd vagrant`

`vagrant up --provider=qemu`

Connecting
----------
`vagrant ssh`

Default password is `vagrant`

Destroying
----------
`vagrant destroy`


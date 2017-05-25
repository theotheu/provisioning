Installation of vagrant
-----------------------
- Go to https://www.virtualbox.org/wiki/Downloads and select virtualbox for your platform
- Go to http://www.vagrantup.com/downloads.html and select vagrant for your platform


Initialization
--------------
`git clone https://github.com/theotheu/vagrant-dev.git`

`cd vagrant-dev`

`vagrant up`

Connecting
----------
`vagrant ssh`

Default password is `vagrant`

Destroying
----------
`vagrant destroy`


Installation of ojdbc6.jar (optional)
--------------------------

Search at google for actual location of ojdbc6.jar at ```https://www.google.nl/search?q=ojdbc6.jar+download```

You might have to login with yout OTN account.

Accept the license agreement and download the file.

Install the plugin with
`mvn install:install-file -Dfile=./ojdbc6.jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.4  -Dpackaging=jar`

Modify your POM to accomodate the version
`
<project ...>
 
	<dependencies>>
 
		<!-- ORACLE database driver -->
		<dependency>
			<groupId>com.oracle</groupId>
			<artifactId>ojdbc6</artifactId>
			<version>11.2.0.4</version>
		</dependency>
 
	</dependencies>
</project>
`

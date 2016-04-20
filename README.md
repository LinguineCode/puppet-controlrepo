puppet-controlrepo
==================

This project serves as a complete starter kit for your Puppet controlled infrastructure. It is feature filled with everything you ever wanted but never had; such as *Hiera*, *R10K*, *Roles and Profiles framework*, and *Vagrant*.

Project Goals
-------------

1.	Whitelabel so that anyone can use this project from a class demo all the way to a full blown Fortune 500 datacenter
2.	Compatible with as many operating systems as possible
3.	Stay current with all the best practices

Installation and Usage
----------------------

1.	Clone the repo
2.	Install some vagrant plugins
	1.	`vagrant plugin install vagrant-cachier`
	2.	`vagrant plugin install vagrant-r10k`
3.	set your desired puppet version in Vagrant-puppet/install_puppet.sh (defaults to Puppet 3)
4.	`vagrant up` and watch your new virtual machine get fully provisioned
5.	`vagrant ssh` and have a look around
6.	Now try making a change to some YAML data. Edit [`common.yaml`](hieradata/common.yaml) and add/remove a DNS server, just for fun
7.	`vagrant provision`, now watch the DNS client configuration recieve your change.

### Setting facter facts for Vagrant to use (i.e. `app_role` or `app_tier`\)

Use environment variables to set facter facts that get passed to Vagrant.

```
$ APP_ROLE=webserver vagrant provision
or...
$ APP_ROLE=webserver APP_TIER=production vagrant provision
```

Compatibility
-------------

Tested with Puppet v3.8 (open source) on CentOS 6.7 and Ubuntu Server 14.04 LTS.

Tested with Puppet v4.4.1 (open source) on Ubuntu Server 14.04 LTS

Contributing
------------

1.	Fork it!
2.	Create your feature branch: `git checkout -b my-new-feature`
3.	Commit your changes: `git commit -am 'Add some feature'`
4.	Push to the branch: `git push origin my-new-feature`
5.	Submit a pull request :D

History
-------

Nov 2015: Initial commit

Credits
-------

[Sean S. King](https://github.com/seanscottking), author

Thanks to [Rob Nelson](http://rnelson0.com). His project [puppetinabox](https://github.com/puppetinabox) was the inspiration for this one.

Thanks to [Craig Dunn](www.craigdunn.org) and [Gary Larizza](http://garylarizza.com) for their broad research on ways to make Puppet not suck.

License
-------

[See LICENSE.md](LICENSE.md)

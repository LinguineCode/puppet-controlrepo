# -*- mode: ruby -*-
# vi: set ft=ruby :

## Uncomment to enable GUI for troubleshooting via console:
#Vagrant.configure("1") do |config|
#  config.vm.boot_mode = :gui
#end

Vagrant.configure("2") do |config|
  config.vm.box = "box-cutter/centos67"
  config.vm.provision :shell, path: "bootstrap_pre.sh"
  config.vm.provision :reload
  config.vm.provision :shell, path: "bootstrap_post.sh"
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

#Vagrant.configure("1") do |config|
#  config.vm.boot_mode = :gui
#end

Vagrant.configure("2") do |config|
  config.vm.box = "puphpet/centos65-x64"
  config.vm.provision :shell, path: "bootstrap.sh"
end

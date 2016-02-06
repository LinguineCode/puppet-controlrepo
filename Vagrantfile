# -*- mode: ruby -*-
# vi: set ft=ruby :

## Uncomment to enable GUI for troubleshooting via console:
#Vagrant.configure("1") do |config|
#  config.vm.boot_mode = :gui
#end

Vagrant.configure("2") do |config|
  config.vm.box = "box-cutter/centos67"
  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']
  
    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end
  
    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
  end
  
  config.vm.provision :shell, :path => "Vagrant-puppet/install_puppet.sh"
  
  config.r10k.puppet_dir = "/"
  config.r10k.puppetfile_path = "Puppetfile"
  config.r10k.module_path = "modules/"
  
  config.vm.provision "puppet" do |puppet|
    #puppet.options = "--verbose"
    puppet.facter = {
      "vagrant" => "vagrant",
      "app_role" => ENV.fetch('APP_ROLE', 'none'),
      "app_tier" => ENV.fetch('APP_TIER', 'none'),
    }
    puppet.manifests_path = "manifests/"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = [ "site/", "modules/" ]
    puppet.hiera_config_path = "Vagrant-puppet/hiera.yaml"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box

    #config.cache.synced_folder_opts = {
    #  type: :nfs,
    #  mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    #}
  end

end

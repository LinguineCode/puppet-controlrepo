# Class: Puppet
#
#
class profile::base::puppet::master {

  $trusted_networks_puppetmaster       = hiera_array('firewall::trusted_networks::puppetmaster')
  $puppet_master_r10k_remote           =      hiera('puppet::master::r10k_remote')
  $puppet_master_hiera_eyaml           =      hiera('puppet::master::hiera_eyaml')
  $puppet_master_hiera_hierarchy       =      hiera('puppet::master::hiera_hierarchy')
  $puppet_master_hiera_datadir         =      hiera('puppet::master::hiera_datadir')
  $puppet_master_hiera_master_service  =      hiera('puppet::master::hiera_master_service')
  $puppet_master_environments          =      hiera('puppet::master::environments')

  # Allow firewall
  #
  #
  profile::base::firewall::allow_puppetmaster { $trusted_networks_puppetmaster: }

  # Set up R10K
  #
  #
  class { '::r10k':
    remote => $puppet_master_r10k_remote,
  }

  # Set up Hiera
  #
  #
  class { '::hiera':
    eyaml          => $puppet_master_hiera_eyaml,
    hierarchy      => $puppet_master_hiera_hierarchy,
    datadir        => $puppet_master_hiera_datadir,
    # Enable this when hunner/hiera module's tag 1.3.3 gets published
    #master_service => $puppet_master_master_service,
  }

  # Setup Puppetmaster
  #
  #
  class { '::puppet::master':
    environments => $puppet_master_environments,
  }
  
}
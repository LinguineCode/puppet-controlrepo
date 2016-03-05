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
  
  firewall { '5000 Puppetmaster':
    action => accept,
    dport  => '8140',
    source => $trusted_networks_puppetmaster,
  }
  
  class { '::r10k':
    remote  => $puppet_master_r10k_remote,
    require => [ Class['puppet::master'], ],
  }
  
  class { '::hiera':
    eyaml     => $puppet_master_hiera_eyaml,
    hierarchy => $puppet_master_hiera_hierarchy,
    datadir   => $puppet_master_hiera_datadir,
    require   => [ Class['puppet::master'], ],
  }
  
  case $::osfamily {
    
    'RedHat': {
      
      yum::repo { 'phusionpassenger':
        baseurl  => 'https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch',
        gpgcheck => '0',
        enabled  => '1',
        gpgkey   => 'https://packagecloud.io/gpg.key',
      }->
      package { 'passenger':
      }->
      class { '::puppet::master':
        environments => $puppet_master_environments,
      }
      
    }
    
    default: {
      class { '::puppet::master':
        environments => $puppet_master_environments,
      }
    }

  }
  
}

# Class: Puppet
#
#
class profile::base::puppet::agent {

  $puppet_server      = hiera('puppet::server')
  $puppet_environment = hiera('puppet::environment')
  
  mkdir::p { '/etc/facter/facts.d': }
  
  if $::environment == 'production' {

    class { '::puppet::agent':
      puppet_server => $puppet_server,
      environment   => $puppet_environment,
    }
    
  }
  else {

    if $::is_pe == true { $puppet_service = 'pe-puppet' }
    else                { $puppet_service = 'puppet'    }

    service { $puppet_service:
      ensure => 'stopped',
      enable => false,
    }

  }
}
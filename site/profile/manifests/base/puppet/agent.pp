# Class: Puppet
#
#
class profile::base::puppet::agent {

  $puppet_server      = hiera('puppet::server')
  $puppet_environment = hiera('puppet::environment')
  

  if $::is_pe == true {
    $puppet_service = 'pe-puppet'
    $factsd         = '/etc/puppetlabs/facter/facts.d'
  }
  else {
    $puppet_service = 'puppet'
    $factsd         = '/etc/facter/facts.d'
  }

  mkdir::p { $factsd: }

  if $::environment == 'production' {
    class { '::puppet::agent':
      puppet_server => $puppet_server,
      environment   => $puppet_environment,
    }
  }

  else {
    service { $puppet_service:
      ensure => 'stopped',
      enable => false,
    }
  }
  
}
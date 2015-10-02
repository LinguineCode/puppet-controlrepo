# Class: Puppet
#
#
class profile::base::puppet::agent {

  $puppet_server      = hiera('puppet::server')
  $puppet_environment = hiera('puppet::environment')

  class { '::puppet::agent':
    puppet_server => $puppet_server,
    environment   => $puppet_environment,
  }
  
}
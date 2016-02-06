# Class: firewall::post
#
#
class profile::base::firewall::post {


  # Allow all outgoing
  firewallchain { 'OUTPUT:filter:IPv4':
    ensure => present,
    policy => accept,
    before => undef,
  }
  
  # Drop all incoming
  firewallchain { 'INPUT:filter:IPv4':
    ensure => present,
    policy => drop,
    before => undef,
  }
  
  # Drop all forwarding
  firewallchain { 'FORWARD:filter:IPv4':
    ensure => present,
    policy => drop,
    before => undef,
  }
  
}
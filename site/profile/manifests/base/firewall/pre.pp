# Class: firewall::pre
#
#
class profile::base::firewall::pre {

  ### Hiera lookups
  #
  #
  $trusted_networks_admin = hiera_array('firewall::trusted_networks::admin')

  ### Hard-coded firewall rules. Do these first.
  #
  #
  
  Firewall {
    require => undef,
  }

  firewall { '0000 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '0001 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.0/8',
    action      => 'reject',
  }->
  firewall { '0002 accept related established rules':
    proto  => 'all',
    state  => [ 'RELATED', 'ESTABLISHED' ],
    action => 'accept',
  } ->
  resources { 'firewall':
    purge => true
  }
  
  ### Create some rules to allow administration
  case $::kernel {
    'Windows': { $adminport = '3389' }
    default:   { $adminport = 'ssh' }
  }

  firewall { '9000 Administration':
    action => accept,
    dport  => $adminport,
    source => $trusted_networks_admin,
  }

  firewall { '9000 ICMP':
    action => accept,
    proto  => icmp,
    source => $trusted_networks_admin,
  }

}
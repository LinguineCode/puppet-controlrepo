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

  profile::base::firewall::allow { "${trusted_networks_admin}_admin":
    description => 'Administration',
    network     => $trusted_networks_admin,
    priority    => '0100',
    dports      => $adminport,
  }

  profile::base::firewall::allow { "${trusted_networks_admin}_icmp":
    description => 'Ping',
    priority    => '0100',
    network     => $trusted_networks_admin,
    proto       => icmp,
  }
  

  # TIP:
  #
  #  Puppet 4.0 has a great new way to iterate over hashes (we are currently 3.x)
  #  Perfect for managing firewall rules as documented here: http://terrarum.net/blog/puppet-infrastructure.html
  #  Example:
  #$trusted_networks = hiera_array('trusted_networks')
  #$trusted_networks.each |$network| {
  #  firewall { "003 allow all traffic from ${network}":
  #    proto  => 'all',
  #    source => $network,
  #    action => 'accept',
  #  }
  #}

}
# Class: nrpe
#
#
class profile::base::nrpe {

  ### Hiera lookups
  #
  #
  $nrpe_trusted_networks = hiera_array('firewall::trusted_networks::nrpe')
  #$nrpe_myplugins        =  hiera_hash('nrpe::myplugins')
  $nrpe_allowed_hosts    =       hiera('nrpe::allowed_hosts')
  

  firewall { '5000 NRPE':
    action => accept,
    dport  => '5666',
    source => $nrpe_trusted_networks,
  }
  
  case $::osfamily {
    RedHat: { $nagios_plugins_package = 'nagios-plugins-all' }
    Debian: { $nagios_plugins_package = 'nagios-plugins' }
    default: { notify { 'Unsupported operating system': } }
  }

  class { '::nrpe':
    nagios_plugins_package => $nagios_plugins_package,
    allowed_hosts          => $nrpe_allowed_hosts,
  }

  # Uncomment when you have some plugins in common.yaml
  #create_resources(nrpe::plugin, $nrpe_myplugins)


}
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

  # Firewall
  #
  #
  profile::base::firewall::allow_nrpe { $nrpe_trusted_networks:
    priority => '0200',
  }

  class { '::nrpe':
    nagios_plugins_package => 'nagios-plugins-all',
    allowed_hosts          => $nrpe_allowed_hosts,
  }

  # Uncomment when you have some plugins in common.yaml
  #create_resources(nrpe::plugin, $nrpe_myplugins)


}
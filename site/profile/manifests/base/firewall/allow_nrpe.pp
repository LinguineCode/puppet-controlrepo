# define firewall::allow_nrpe
#
#
define profile::base::firewall::allow_nrpe (
  $network  = $name,
  $priority = 5000,
) {

  $nicename = 'NRPE'
  $dport = [ '5666' ]

  firewall { "${priority} Allow ${nicename} from ${network}":
    action => accept,
    proto  => 'tcp',
    dport  => $dport,
    source => $network,
  }

}
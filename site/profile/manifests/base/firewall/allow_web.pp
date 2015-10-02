# define firewall::allow_web
#
#
define profile::base::firewall::allow_web (
  $network  = $name,
  $priority = 5000,
) {

  $nicename = 'Web'
  $dport = [ '80', '443' ]

  firewall { "${priority} Allow ${nicename} from ${network}":
    action => accept,
    proto  => 'tcp',
    dport  => $dport,
    source => $network,
  }

}
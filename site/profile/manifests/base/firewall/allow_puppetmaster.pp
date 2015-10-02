# define firewall::allow_web
#
#
define profile::base::firewall::allow_puppetmaster (
  $network  = $name,
  $priority = 5000,
) {

  $nicename = 'Puppetmaster'
  $dport = [ '8140' ]

  firewall { "${priority} Allow ${nicename} from ${network}":
    action => accept,
    proto  => 'tcp',
    dport  => $dport,
    source => $network,
  }

}
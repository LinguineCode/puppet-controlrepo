# define firewall::allow_admin
#
#
define profile::base::firewall::allow_admin (
  $network  = $name,
  $priority = 0100,
) {

  $nicename = 'Administration'
    case $::kernel {
      'Windows': { $adminport = '3389' }
      default:   { $adminport = 'ssh' }
    }
  $dport = $adminport

  firewall { "${priority} Allow ${nicename} from ${network}":
    action => accept,
    proto  => 'tcp',
    dport  => $dport,
    source => $network,
  }

  firewall { "${priority} Allow ICMP from ${network}":
    action => accept,
    proto  => 'icmp',
    source => $network,
  }

}
# define firewall::allow
#
#
define profile::base::firewall::allow (
  $network     = $name,
  $dports      = undef,
  $priority    = 5000,
  $description = undef,
  $proto       = tcp,
) {
  

  if $description == undef { $_description = '[unspecified]' }
  else { $_description = $description }

  if $proto == 'icmp' {
    firewall { "${priority} Allow ${_description} from ${network}":
      action => accept,
      proto  => $proto,
      source => $network,
    }
  }
  else {
    if $dports == undef { fail('Please define ports') }
    else {
      firewall { "${priority} Allow ${_description} from ${network}":
        action => accept,
        proto  => $proto,
        dport  => $dports,
        source => $network,
      }
    }
  }

}
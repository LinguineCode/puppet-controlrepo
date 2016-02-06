# Class: NTP
#
#
class profile::base::ntp {

  $ntp_servers = hiera('ntp::servers')

  class { '::ntp':
    servers => $ntp_servers,
  }
  
}
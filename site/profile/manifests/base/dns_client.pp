# Class: dns_client
#
#
class profile::base::dns_client {
  
  $resolv_conf_searchpath  = hiera('resolv_conf::searchpath')
  $resolv_conf_nameservers = hiera('resolv_conf::nameservers')

  class { '::resolv_conf':
    searchpath  => $resolv_conf_searchpath,
    nameservers => $resolv_conf_nameservers,
  }
  
}
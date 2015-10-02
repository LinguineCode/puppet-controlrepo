# Class: Firewall
#
#
class profile::base::firewall {
  
  Firewall {
    before  => Class['profile::base::firewall::post'],
    require => Class['profile::base::firewall::pre'],
  }

  class { ['profile::base::firewall::pre', 'profile::base::firewall::post']: }
  class { '::firewall': }

  #resources { 'firewallchain':
  #  purge => true
  #}
  #
  # Why does this cause the following errors? 
  #   Error: Execution of '/sbin/ip6tables -t filter -X INPUT' returned 1: ip6tables: Invalid argument. Run `dmesg' for more information.
  #   Error: Execution of '/sbin/ip6tables -t filter -X OUTPUT' returned 1: ip6tables: Invalid argument. Run `dmesg' for more information.
  #   Error: Execution of '/sbin/ip6tables -t filter -X FORWARD' returned 1: ip6tables: Invalid argument. Run `dmesg' for more information.
  
}
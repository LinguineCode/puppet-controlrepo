# Class: base profile
#
#
class profile::base {
  
  # Profiles that universally support (or are easily able to
  # universally support) all platforms. include them here in base.
  # 
  include profile::base::puppet::agent
  include profile::base::firewall
  include profile::base::ntp
  include profile::base::timezone
  include profile::base::supplementary_packages
  #include profile::base::dns_client, nrpe, auth
  #                      #    ^-- Profiles that *SHOULD* be universal, but are not yet


  # Extra items for specific OS kernels
  #
  #
  case $::kernel {
    'Linux': {
      include profile::base::motd
      include profile::base::ssh
      include profile::base::dns_client
      include profile::base::access_and_sudoers
      include profile::base::nrpe
      include profile::base::logrotate
      include profile::base::postfix
    }
    #'Windows': {
    #  include profile::base::lolwindows
    #  include profile::base::antivirus_programs
    #  include profile::base::adware_removers
    #  include profile::base::reboot_every_day
    #}
    default: { notify { "${::kernel} is not supported by this system. Please contact Puppet admins" : } }
  }


  # Extra items for specific OS Families
  #
  #
  case $::osfamily {
    'RedHat': {
      include profile::base::yum
      include profile::base::selinux
      #include profile::base::authentication
    }
    'Debian': {
      
    }
    default: { notify { "${::osfamily} is not supported. Please contact Puppet admins" : } }
  }


  # Extra items for specific Operating Systems
  #
  #
  case $::operatingsystem {
    'RedHat': {
      include profile::base::rhn_satellite
    }
    'CentOS': {

    }
    'Debian': {
      
    }
    'Ubuntu': {
      
    }
    default: { notify { "${::operatingsystem} is not supported by this system. Please contact Puppet admins" : } }
  }
  
  # Extra items for specific Hypervisors
  #
  #
  if $::vagrant == 'vagrant' {
    include profile::base::vagrant
  }

  if $::ec2_services_domain {
    include profile::base::aws
  }

}
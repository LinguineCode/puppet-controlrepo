# Class: SELinux
#
#
class profile::base::selinux {

  $selinux_mode = hiera('selinux::mode')

  class { '::selinux':
    mode => $selinux_mode,
  }

}
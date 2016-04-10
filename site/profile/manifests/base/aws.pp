# Class: aws
#
#
class profile::base::aws {

  $aws_admin_username = downcase($::operatingsystem)
  
  # FIXME: Figure out how to do this in Hiera
  profile::base::access_and_sudoers::allow { $aws_admin_username:
    sudoer_content => 'ALL=(ALL) NOPASSWD:ALL',
  }
  
  host { 'localhost':
    ip           => '127.0.0.1',
    host_aliases => [ $::hostname, ],
  }

}

# Class: sudo
#
#
class profile::base::access_and_sudoers {

  # Hiera lookups
  #
  #
  $access_and_sudoers_allow  = hiera_hash(access_and_sudoers::allow)

  # Create sudoer and access.conf entries from hiera lookups
  #
  #
  create_resources(profile::base::access_and_sudoers::allow, $access_and_sudoers_allow)

  ### Below this line are hard-coded access/sudoer rules ###

  # Hard-coded sudo default options
  sudo::conf {
    'timeout': priority => '100', content  => 'Defaults        timestamp_timeout=30',
  }

  # Hard-coded access.conf defaults
  # Make sure priority for "root" is a low value i.e. 0-10
  # Make sure priority for "ALL" is a high value i.e. 90-100
  pam::access { 'root': permission => '+', entity => 'root', origin => 'ALL', priority => '10', }
  pam::access { 'ALL':  permission => '-', entity => 'ALL',  origin => 'ALL', priority => '90', }

}
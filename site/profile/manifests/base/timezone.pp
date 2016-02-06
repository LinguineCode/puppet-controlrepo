# Class: Timezone
#
#
class profile::base::timezone {
  
  $timezone_timezone = hiera('timezone::timezone')

  class { '::timezone':
    timezone => $timezone_timezone,
  }
  
}
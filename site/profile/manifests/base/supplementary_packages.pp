# Class: Packages
#
#
class profile::base::supplementary_packages {

  # Hiera lookups
  #
  #
  $supplementary_packages = hiera_array("supplementary_packages::${::osfamily}")

  # Install supplementary packages
  package { $supplementary_packages:
    ensure => installed,
  }

}
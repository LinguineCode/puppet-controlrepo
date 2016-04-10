# Class: Packages
#
#
class profile::base::supplementary_packages {

  $supplementary_packages = hiera_array("supplementary_packages::${::osfamily}")


  ensure_packages($supplementary_packages)

}
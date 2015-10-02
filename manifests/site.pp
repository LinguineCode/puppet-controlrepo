# site.pp

node default {
  if $::app_role or $::puppet_role {
    hiera_include('classes')
  }
  else {
    notify { "${::clientcert} does not have a specific role assigned, using only role::base": }
    include role::base
  }

}

# This fixes the following problem: 
# https://ask.puppetlabs.com/question/6640/warning-the-package-types-allow_virtual-parameter-will-be-changing-its-default-value-from-false-to-true-in-a-future-release/
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
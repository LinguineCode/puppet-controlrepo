# Class base role
#
#
class role::base {
  
  notify { "${::clientcert} does not have a specific role assigned, using only role::base": }

  include profile::base
}
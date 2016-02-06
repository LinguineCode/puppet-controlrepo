# Class role::puppet::allinone
#
#
class role::puppet::allinone {
  include profile::base
  include profile::base::puppet::master
}
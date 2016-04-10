# Class role::puppet::master
#
#
class role::puppet::master {
  include profile::base
  include profile::base::puppet::master
}
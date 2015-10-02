# Class: yum
#
#
class profile::base::yum {

  package { 'epel-release-6-8.noarch':
    provider => 'rpm',
    source   => 'http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
  }

  if !$::is_pe {
    package { 'puppetlabs-release-el-6.noarch':
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm',
    }
  }

}
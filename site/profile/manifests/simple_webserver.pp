# Class: Simple Webserver
#
#
class profile::simple_webserver {

  $vhostname          = hiera('apache::vhostname')
  $docroot            = hiera('apache::docroot')
  $port               = hiera('apache::port')
  $index_content      = hiera('apache::index_content')
  $firewall_allow_web = hiera('firewall::allow_web')

  firewall { '5000 HTTP/HTTPS':
    action => accept,
    dport  => [ '80', '443', ],
    source => $firewall_allow_web,
  }

  class { 'apache':
    default_vhost => false,
  }

  file { "${docroot}/index.html":
    content => $index_content,
    require => [ Apache::Vhost[$vhostname], ],
  }

  apache::vhost { $vhostname:
    port    => $port,
    docroot => $docroot,
  }
  
}
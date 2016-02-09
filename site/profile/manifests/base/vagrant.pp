# Class: virtualbox
#
#
class profile::base::vagrant {

  file { '/etc/facter/facts.d/vagrant.txt':
    ensure  => present,
    require => [ Mkdir::P['/etc/facter/facts.d'], ],
  } ->
  file_line { 'vagrant_fact':
    line  => 'vagrant=vagrant',
    path  => '/etc/facter/facts.d/vagrant.txt',
    match => '^vagrant=',
  }

}
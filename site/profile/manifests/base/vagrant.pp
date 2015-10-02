# Class: virtualbox
#
#
class profile::base::vagrant {
  
  ### Decided this was better off in Hiera.
  
  #if $::virtual == 'virtualbox' {
  #
  #  firewall { '0005 accept SSH from 10.0.0.0/8':
  #    proto  => 'tcp',
  #    source => '10.0.0.0/8',
  #    port   => 'ssh',
  #    action => 'accept',
  #  }
  # 
  #  sudo::conf { 'vagrant':
  #    priority => '100',
  #    content  => '%vagrant     ALL=(ALL)       ALL',
  #  }
  # 
  #}
  
}
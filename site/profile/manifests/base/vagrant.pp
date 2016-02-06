# Class: virtualbox
#
#
class profile::base::vagrant {
  
  file_line { 'GC.disable':
    path  => '/usr/bin/puppet',
    after => '^#!',
    line  => 'GC.disable',
  }
  
}
# Class: MOTD
#
#
class profile::base::motd {

  if $::osfamily == 'RedHat' {

    package { 'figlet': }
    
    $ascii = generate('/bin/sh', '-c', "/usr/bin/figlet -c -w 60 ${::domain}")

    if $::is_pe == true {
      $agent      = 'Puppet Enterprise Agent'
      $classestxt = '/var/opt/lib/pe-puppet/classes.txt'
    }
    else {
      $agent      = 'Puppet Agent'
      $classestxt = '/var/lib/puppet/classes.txt'
    }

    if !$app_role { $app_role = 'none' }
    if !$app_tier { $app_tier = 'none' }

    file { '/etc/profile.d/motd.sh':
      mode    => '0755',
      content => template('profile/motd/motd.sh.erb')
    }

    file { '/etc/issue.net':
      mode    => '0644',
      content => template('profile/motd/issue.net.erb')
    }

    file { '/tmp/classes.tmp':
      source             => $classestxt,
      source_permissions => 'ignore',
    }


  }

  else {
    notify { "${::osfamily} OS family not supported": }
  }

}
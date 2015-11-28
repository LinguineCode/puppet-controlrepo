#!/bin/bash


e() {
  echo "$0: $@"
}
err() {
  >&2 e "Error: $@"
}

if [[ $EUID -ne 0 ]]; then
  err "This script must be run as root"
  exit 1
fi

if [ -f /etc/redhat-release ]; then

  yum install -y redhat-lsb-core

  case "$(lsb_release -sr | cut -d'.' -f1)" in

    6)
      yum install -y http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
      yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
      
      # Passenger - This area needs attention
      #1 - Enable GPG checks on Phusion's repo
      #2 - Why do we need to un-disable SELinux? Because "yum install passenger" has a problem. See bootstrap-pre.sh file.

      wget -O /etc/yum.repos.d/el-passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
      yum install -y --nogpgcheck passenger mod_passenger

      echo "Setting SELinux to permissive mode"
      sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
      ;;

    *)
      err "Unsupported Operating System Version"
      exit 1
      ;;

  esac
  
  yum install -y puppet

#elif [ -f /etc/debian_version ]; then
#  # do some Debian stuff here

else
  err "Unsupported Operating System"
  exit 1

fi

puppet module install --modulepath=/usr/share/puppet/modules/ stephenrjohnson-puppet
puppet module install --modulepath=/usr/share/puppet/modules/ zack-r10k
puppet module install --modulepath=/usr/share/puppet/modules/ hunner/hiera

mkdir -p /etc/facter/facts.d
cat >/etc/facter/facts.d/facts.txt <<EOL
vagrant=vagrant

app_role=puppet-allinone
app_tier=development
EOL

su - vagrant << \EOF
sudo yum install -y figlet

sudo puppet apply -e 'host { puppet: ip => "127.0.1.1", }'
sudo puppet apply -e 'class { "::r10k": remote => "https://github.com/seanscottking/puppet-controlrepo.git", }'
sudo puppet apply -e 'class { "::hiera": eyaml => true, hierarchy => [ "app_role/%{::app_role}", "app_tier/%{::app_tier}", "vagrant/%{::vagrant}", common, ], datadir => "/etc/puppet/environments/%{::environment}/hieradata", }'
sudo puppet apply -e 'class { "::puppet::master": environments => "directory", }'

sudo r10k deploy environment -p

sudo puppet agent -t

EOF

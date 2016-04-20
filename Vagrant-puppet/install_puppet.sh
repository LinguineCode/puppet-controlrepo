#!/bin/bash

# Select your puppet version to install (3 || 4)
puppet_version=3

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

if [ -f '/etc/redhat-release' ]; then

  if [ "$(which puppet)" ]; then
    # Puppet already installed, exiting silently
    exit 0
  else

    yum install -y redhat-lsb-core

    case "$(lsb_release -sr | cut -d'.' -f1)" in

        6)
          yum install -y http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
          yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
          ;;

        *)
          err "Unsupported Operating System Version"
          exit 1
          ;;

    esac
  fi

  yum install -y puppet

elif [ -f '/etc/debian_version' ]; then

  case "$puppet_version" in

    4) if [ ! puppet --version == 4* ]; then
        echo "Puppet Agent 4.x.x is already installed. Moving on..."
    else

      # Add puppet repo and install puppet
      wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && \
      sudo dpkg -i puppetlabs-release-pc1-trusty.deb && \
      sudo apt-get update -yq && \
      sudo apt-get -o Dpkg::Options::="--force-confold" install -yq puppet-agent

      # Link puppet install to /usr/bin so it is in out PATH
      sudo ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet

      # Add puppet cron job to refresh every 30 mins
      sudo puppet resource cron puppet-agent ensure=present user=root minute=30 \
        command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

      # Ensure the puppet agent is running
      sudo puppet resource service puppet ensure=running enable=true
    fi;;

  3) if [ ! puppet --version == 3* ]; then
      echo "Puppet Agent 3.x.x is already installed. Moving on..."
    else
      SHORT_CODENAME="$(lsb_release -c -s)"
      wget -O /tmp/puppetlabs-release-"$SHORT_CODENAME".deb https://apt.puppetlabs.com/puppetlabs-release-"$SHORT_CODENAME".deb
      dpkg -i /tmp/puppetlabs-release-"$SHORT_CODENAME".deb
      apt-get update
      DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install puppet
    fi;;

  *) err "You must select either Puppet version 3 or 4"
    exit 1;;

  esac

else
  err "Unsupported Operating System"
  exit 1

fi

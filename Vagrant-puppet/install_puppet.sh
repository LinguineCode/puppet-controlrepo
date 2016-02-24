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
  
  if [ "$(dpkg -S puppetlabs-release 2>/dev/null)" ]; then
    # Puppet repo already installed, exiting silently
    exit 0
  else
    SHORT_CODENAME="$(lsb_release -c -s)"
    wget -O /tmp/puppetlabs-release-"$SHORT_CODENAME".deb https://apt.puppetlabs.com/puppetlabs-release-"$SHORT_CODENAME".deb
    dpkg -i /tmp/puppetlabs-release-"$SHORT_CODENAME".deb
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install puppet
  fi

else
  err "Unsupported Operating System"
  exit 1

fi

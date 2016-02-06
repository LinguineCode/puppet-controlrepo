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

if [ "$(which puppet)" ]; then
  # Puppet already installed, exiting silently
  exit 0
fi

if [ -f /etc/redhat-release ]; then

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
  
  yum install -y puppet

#elif [ -f /etc/debian_version ]; then
#  # do some Debian stuff here

else
  err "Unsupported Operating System"
  exit 1

fi

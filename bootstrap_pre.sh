#!/bin/bash

# This script solves the following yum error when
# attempting to "yum install passenger" on (at least) CentOS 6

###  Installing : 1:rubygem-rack-1.1.0-2.el6.noarch                                                                      1/3 
###
###   !!!! PASSENGER CANNOT BE INSTALLED: KERNEL TOO OLD !!!!
###
###   You are currently running kernel 2.6.32-573.el6.x86_64, with SELinux policy
###   version 24. However, Passenger's SELinux policy requires kernel >= 2.6.39,
###   with support for policy version >= 25.
###
###   There are two ways to solve this problem:
###
###   Alternative 1: upgrade your kernel to at least 2.6.39, then reinstall
###   Passenger.
###
###   -OR-
###
###   Alternative 2: disable SELinux.
###   Edit /etc/selinux/config, set SELINUX=disabled, reboot, then
###   reinstall Passenger.
###
###error: %pre(passenger-5.0.21-8.el6.x86_64) scriptlet failed, exit status 1
###Error in PREIN scriptlet in rpm package passenger-5.0.21-8.el6.x86_64
###error:   install: %pre scriptlet failed (2), skipping passenger-5.0.21-8.el6

echo 'Disabling SELinux to do "yum install passenger"'
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
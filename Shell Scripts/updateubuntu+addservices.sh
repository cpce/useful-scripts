#!/bin/bash

#Update Ubuntu

apt-get update -y

#Upgrade Ubuntu

apt-get upgrade -y

#Install CIFS

apt-get install cifs-utils -y

#Install NFS

apt-get install nfs-common -y

#Add universe repo and install fail2ban

add-apt-repository universe -y
apt-get update -y
apt-get install fail2ban -y

#Reboot Ubuntu

reboot
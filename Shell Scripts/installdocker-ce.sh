#!/bin/bash

#add docker key

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#add docker repo

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

#app update

apt-get update -y

#install docker

apt-get install docker-ce -y
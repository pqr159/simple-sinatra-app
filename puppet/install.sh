#!/bin/sh

# install puppet
if [ -f /etc/lsb-release ] && [ ! -f /etc/redhat-release ]; 
then
	# update and upgrade apt-get 
	sudo apt-get -y update
	sudo apt-get -y upgrade

	# install puppet 
	sudo apt-get -y install puppet
fi


# Install the rea-test puppet module into the puppet

# Test the configuration locally to validate configuration
# puppet apply -e "include rea-test"

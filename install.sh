#!/bin/bash

if [[ "$(id -u)" != "0" ]]; then
	echo "Run installer as root"
	exit 1
fi

if [[ ! -d "/home/$1"  || "$1" == "" ]]; then
	echo "Please specify the user to run as"
	echo "bash $0 $USER"
	exit 1
fi	

cp ./scripts/* /usr/local/bin/

cp rules/* /etc/udev/rules.d/

udevadm control --reload-rules


SERIAL=$(su $1 -c 'gpg --card-status' | grep Serial | awk '{print $NF}')

echo "Found yubikey serial number: $SERIAL"

if [[ "$SERIAL" -gt "0" ]]; then
	echo "export YK_SERIAL='$SERIAL'" >> ~/.profile
	echo "export YK_SERIAL='$SERIAL'" | sudo tee -a /root/.profile
fi

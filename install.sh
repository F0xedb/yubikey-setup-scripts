#!/bin/bash

if [[ "$(id -u)" != "0" ]]; then
	echo "Run installer as root"
	exit 1
fi

cp ./scripts/* /usr/local/bin/

cp rules/* /etc/udev/rules.d/

udevadm control --reload-rules

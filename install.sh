#!/bin/bash

if [[ "$UID" != 0 ]]; then
	sudo "$0" "$@"
	exit
fi
install qusbkill /usr/bin/
install qusbkill.service /etc/systemd/system/
install uk /usr/bin/

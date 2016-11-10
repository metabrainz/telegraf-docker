#!/bin/bash

while [ ! -e /run/syslog-ng.pid ]; do
	sleep 1
done

exec 1> >(logger) 2>&1

source /etc/container_environment.sh

exec /usr/bin/telegraf -config /etc/telegraf/telegraf.conf -config-directory /etc/telegraf/telegraf.d 

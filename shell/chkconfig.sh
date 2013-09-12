#!/bin/bash
if [[ $1 == "on" ]]; then
	echo update-rc.d -f defaults begin
	update-rc.d -f apache2 defaults 
	update-rc.d -f bluetooth defaults 
	update-rc.d -f memcached defaults
	update-rc.d -f nginx defaults
	update-rc.d -f openvpn defaults
	update-rc.d -f puppet defaults
	update-rc.d -f puppetmaster defaults
	update-rc.d -f puppetqd defaults
	update-rc.d -f redis-server defaults
	update-rc.d -f sphinxsearch defaults
	echo update-rc.d -f defaults end
elif [[ $1 == "off" ]]; then
	echo update-rc.d -f remove begin
	update-rc.d -f apache2 remove 
	update-rc.d -f bluetooth remove 
	update-rc.d -f memcached remove
	update-rc.d -f nginx remove
	update-rc.d -f openvpn remove
	update-rc.d -f puppet remove
	update-rc.d -f puppetmaster remove
	update-rc.d -f puppetqd remove
	update-rc.d -f redis-server remove
	update-rc.d -f sphinxsearch remove
	echo update-rc.d -f remove end
fi

#!/bin/bash
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'`
if [[ $OS == "Ubuntu" ]]; then
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version
else
	OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version
fi
OS_SUFFIX=`uname -m`
OS_SUFFIX_SPECIAL=$OS_SUFFIX
if [[ $OS_SUFFIX == "i686" ]]; then
	OS_SUFFIX_SPECIAL=i386
	if [[ $Version == "5.9" ]]; then
		OS_SUFFIX="i386"
	fi
fi
if [ -f "/etc/init.d/nginx" ]; then
	sudo /etc/init.d/nginx start
elif [ -f "/usr/sbin/nginx" ]; then
	sudo /usr/sbin/nginx
fi
if [ -f "/etc/init.d/php-fpm" ]; then
	sudo /etc/init.d/php-fpm start
elif [ -f "/usr/sbin/php-fpm" ]; then
	sudo /usr/sbin/php-fpm -y /etc/php-fpm.conf -g /var/run/php-fpm.pid
fi
if [ -f "/etc/init.d/mysqld" ]; then
	sudo /etc/init.d/mysqld start
elif [ -f "/usr/share/mysql/mysql.server" ]; then
	sudo /usr/share/mysql/mysql.server start
fi
if [ -f "/etc/init.d/httpd" ]; then
	sudo /etc/init.d/httpd start
elif [ -f "/usr/sbin/httpd" ]; then
	sudo /usr/sbin/httpd -k start
fi

#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
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
for i in $*; do 
	if [[ $i == "nginx" ]]; then
		if [ -f "/etc/init.d/nginx" ]; then
			sudo /etc/init.d/nginx restart
		elif [ -f "/usr/sbin/nginx" ]; then
			sudo /usr/sbin/nginx -s reload
		fi
	elif [[ $i == "httpd" ]]; then
		if [ -f "/etc/init.d/httpd" ]; then
			sudo /etc/init.d/httpd restart
		elif [ -f "/usr/sbin/httpd" ]; then
			sudo /usr/sbin/httpd -k restart
		fi
	elif [[ $i == "mysql" ]]; then
		if [ -f "/etc/init.d/mysqld" ]; then
			sudo /etc/init.d/mysqld restart
		elif [ -f "/usr/share/mysql/mysql.server" ]; then
			sudo mysqladmin -u root -p shutdown
			sudo mysqld_safe &
		fi
	elif [[ $i == "php" ]]; then
		if [ -f "/etc/init.d/php-fpm" ]; then
			sudo /etc/init.d/php-fpm restart
		elif [ -f "/usr/sbin/php-fpm" ]; then
			sudo kill -INT `cat /var/run/php-fpm/php-fpm.pid`
			sudo /usr/sbin/php-fpm -y /etc/php-fpm.conf -g /var/run/php-fpm/php-fpm.pid
			#sudo kill -USR2 `cat /var/run/php-fpm/php-fpm.pid`
		fi
	fi
done

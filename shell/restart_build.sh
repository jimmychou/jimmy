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
			echo Restart Progress Nginx Finish!
		elif [ -f "/usr/sbin/nginx" ]; then
			sudo /usr/sbin/nginx -s reload
			echo Restart Progress Nginx Finish!
		fi
	elif [[ $i == "httpd" ]]; then
		if [ -f "/etc/init.d/httpd" ]; then
			sudo /etc/init.d/httpd restart
			echo Restart Progress Httpd Finish!
		elif [ -f "/usr/sbin/httpd" ]; then
			sudo /usr/sbin/httpd -k restart
			echo Restart Progress Httpd Finish!
		fi
	elif [[ $i == "mysql" ]]; then
		if [ -f "/etc/init.d/mysqld" ]; then
			sudo /etc/init.d/mysqld restart
			echo Restart Progress Mysqld Finish!
		elif [ -f "/usr/share/mysql/mysql.server" ]; then
			sudo mysqladmin -u root -p shutdown
			echo Kill Progress Mysqld Finish!
			sudo mysqld_safe &
			echo Start Progress Mysqld Finish!
		fi
	elif [[ $i == "php" ]]; then
		if [ -f "/etc/init.d/php-fpm" ]; then
			sudo /etc/init.d/php-fpm restart
			echo Restart Progress FPM Finish!
		elif [ -f "/usr/sbin/php-fpm" ]; then
			sudo kill -INT `cat /var/run/php-fpm/php-fpm.pid`
			sudo rm -f /var/run/php-fpm/php-fpm.pid	#	这是必需的么？
			echo Kill Progress FPM Finish!
			sudo /usr/sbin/php-fpm -y /etc/php-fpm.conf -g /var/run/php-fpm/php-fpm.pid
			echo Start Progress FPM Finish!
			#sudo kill -USR2 `cat /var/run/php-fpm/php-fpm.pid`
		fi
	elif [[ $i == "memcached" ]]; then
		if [ -f "/etc/init.d/memcached" ]; then
			sudo /etc/init.d/memcached restart
			echo Restart Progress Memcached Finish!
		elif [ -f "/usr/bin/memcached" ]; then
			#sudo killall memcached
			sudo kill -INT `cat /var/run/memcached/memcached.pid`
			sudo rm -f /var/run/memcached/memcached.pid
			echo Kill Progress Memcached Finish!
			sudo /usr/bin/memcached -d -p 11211 -u memcached -m 64 -c 1024 -P /var/run/memcached/memcached.pid
			echo Start Progress Memcached Finish!
		fi
	fi
done

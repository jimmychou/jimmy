#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
source ./release.sh
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
		if [[ $OS == "Ubuntu" ]]; then
			if [[ $Codename == "precise" ]]; then
				if [ -f "/etc/init.d/apache2" ]; then
					sudo /etc/init.d/apache2 restart
					echo Restart Progress Httpd Finish!
				elif [ -f "/usr/sbin/apache2ctl" ]; then
					#貌似还有问题
					sudo /usr/sbin/apache2ctl -k restart
					echo Restart Progress Httpd Finish!
				fi
			fi
		elif [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				if [ -f "/etc/init.d/httpd" ]; then
					sudo /etc/init.d/httpd restart
					echo Restart Progress Httpd Finish!
				elif [ -f "/usr/sbin/httpd" ]; then
					sudo /usr/sbin/httpd -k restart
					echo Restart Progress Httpd Finish!
				fi
			fi
		fi
	elif [[ $i == "mysql" ]]; then
		if [[ $OS == "Ubuntu" ]]; then
			if [[ $Codename == "precise" ]]; then
				if [ -f "/etc/init.d/mysql" ]; then
					sudo /etc/init.d/mysql restart
					echo Restart Progress Mysqld Finish!
				elif [ -f "/usr/bin/mysqld_safe" ]; then
					#尚有问题，还需解决
					sudo mysqladmin -u root --password="penny7531" shutdown
					echo Kill Progress Mysqld Finish!
					sudo mysqld_safe &
					echo Start Progress Mysqld Finish!
				fi
			fi
		elif [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				if [ -f "/etc/init.d/mysqld" ]; then
					sudo /etc/init.d/mysqld restart
					echo Restart Progress Mysqld Finish!
				elif [ -f "/usr/share/mysql/mysql.server" ]; then
					sudo mysqladmin -u root -p shutdown
					#sudo mysqladmin -u root --password="penny7531" shutdown
					echo Kill Progress Mysqld Finish!
					sudo mysqld_safe &
					echo Start Progress Mysqld Finish!
				fi
			fi
		fi
	elif [[ $i == "php" ]]; then
		if [[ $OS == "Ubuntu" ]]; then
			if [[ $Codename == "precise" ]]; then
				if [ -f "/etc/init.d/php5-fpm" ]; then
					sudo /etc/init.d/php5-fpm restart
					echo Restart Progress FPM Finish!
				elif [ -f "/usr/sbin/php5-fpm" ]; then
					sudo kill -INT `cat /var/run/php5-fpm.pid`
					#sudo rm -f /var/run/php5-fpm.pid	#	此时无需
					echo Kill Progress FPM Finish!
					sudo /usr/sbin/php5-fpm -y /etc/php5/fpm/php-fpm.conf -g /var/run/php5-fpm.pid
					echo Start Progress FPM Finish!
					#sudo kill -USR2 `cat /var/run/php-fpm/php-fpm.pid`
				fi
			fi
		elif [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
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
			fi
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

#!/bin/bash
SCRIPT_ACTION=INSTALL_MINIMUM
source ./release.sh
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "hardy" ]]; then
		sudo apt-get $INSTALL_OPTION install git-core php5-memcache
		# git-core - fast, scalable, distributed revision control system
		# php5-memcache - memcache extension module for PHP5
	elif [[ $Codename == "lucid" ]]; then
		sudo apt-get $INSTALL_OPTION install git-core php5-cli php5-memcached
		# git-core - fast, scalable, distributed revision control system
		# php5-cli - command-line interpreter for the php5 scripting language
		# php5-memcached - memcached extension module for PHP5, uses libmemcached
	elif [[ $Codename == "precise" ]]; then
		sudo apt-get $INSTALL_OPTION install git php5-fpm php5-memcached
		# git - fast, scalable, distributed revision control system
		# php5-fpm - server-side, HTML-embedded scripting language (FPM-CGI binary)
		# php5-memcached - memcached extension module for PHP5, uses libmemcached
	elif [[ $Codename == "quantal" ]]; then
		sudo apt-get $INSTALL_OPTION install git php5-fpm php5-memcached
		# git - fast, scalable, distributed revision control system
		# php5-fpm - server-side, HTML-embedded scripting language (FPM-CGI binary)
		# php5-memcached - memcached extension module for PHP5, uses libmemcached
	elif [[ $Codename == "raring" ]]; then
		sudo apt-get $INSTALL_OPTION install git php5-fpm php5-memcached
		# git - fast, scalable, distributed revision control system
		# php5-fpm - server-side, HTML-embedded scripting language (FPM-CGI binary)
		# php5-memcached - memcached extension module for PHP5, uses libmemcached
	fi
	sudo apt-get $INSTALL_OPTION install apache2 g++ libapache2-mod-php5 memcached mysql-server nginx php5 php5-cgi php5-dev php5-mysql phpmyadmin vim
	# apache2 - Apache HTTP Server metapackage
	# g++ - GNU C++ compiler
	# libapache2-mod-php5 - server-side, HTML-embedded scripting language (Apache 2 module)
	# memcached - A high-performance memory object caching system
	# mysql-server - MySQL database server (metapackage depending on the latest version)
	# nginx - small, but very powerful and efficient web server and mail proxy
	# php5 - server-side, HTML-embedded scripting language (metapackage)
	# php5-cgi - server-side, HTML-embedded scripting language (CGI binary)
	# php5-dev - Files for PHP5 module development
	# php5-mysql - MySQL module for php5
	# phpmyadmin - MySQL web administration tool
	# vim - Vi 增强版 - 增强的 vi 编辑器
else
	if [[ $OS == "Fedora" ]]; then
		if [[ $Version == "12" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX php-mysql.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "13" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX php-mysql.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "14" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX php-mysql.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "15" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX php-fpm.$OS_SUFFIX php-mysql.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "16" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX php-fpm.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "17" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX phpMemcachedAdmin.noarch php-fpm.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			##phpMemcachedAdmin.noarch : Graphic stand-alone administration for memcached to monitor and debug purpose
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "18" ]]; then
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX phpMemcachedAdmin.noarch php-fpm.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			##phpMemcachedAdmin.noarch : Graphic stand-alone administration for memcached to monitor and debug purpose
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		elif [[ $Version == "19" ]]; then
			yum $INSTALL_OPTION install community-mysql-server.$OS_SUFFIX phpMemcachedAdmin.noarch php-fpm.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX
			# community-mysql-server.$OS_SUFFIX : The MySQL server and related files
			##phpMemcachedAdmin.noarch : Graphic stand-alone administration for memcached to monitor and debug purpose
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		else
			yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX community-mysql-server.$OS_SUFFIX phpMemcachedAdmin.noarch php-fpm.$OS_SUFFIX php-mysql.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX
			# mysql-server.$OS_SUFFIX : The MySQL server and related files
			# community-mysql-server.$OS_SUFFIX : The MySQL server and related files
			##phpMemcachedAdmin.noarch : Graphic stand-alone administration for memcached to monitor and debug purpose
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
			# php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		fi
		yum $INSTALL_OPTION install git.$OS_SUFFIX memcached.$OS_SUFFIX nginx.$OS_SUFFIX php-pecl-memcached.$OS_SUFFIX phpMyAdmin.noarch yum-plugin-fastestmirror.noarch
		# git.$OS_SUFFIX : Fast Version Control System
		# memcached.$OS_SUFFIX : High Performance, Distributed Memory Object Cache
		# nginx.$OS_SUFFIX : A high performance web server and reverse proxy server
		# php-pecl-memcached.$OS_SUFFIX : Extension to work with the Memcached caching daemon
		# phpMyAdmin.noarch : Handle the administration of MySQL over the World Wide Web
		# yum-plugin-fastestmirror.noarch : Yum plugin which chooses fastest repository from a mirrorlist
	elif [[ $OS == "CentOS" ]]; then
		if [[ $PrimaryVersion == "5" ]]; then
			yum $INSTALL_OPTION install phpmyadmin.noarch yum-fastestmirror.noarch
			# phpmyadmin.noarch : Web application to manage MySQL
			# yum-fastestmirror.noarch : Yum plugin which chooses fastest repository from a mirrorlist
		else 
			yum $INSTALL_OPTION install git.$OS_SUFFIX memcached.$OS_SUFFIX phpMyAdmin.noarch php-fpm.$OS_SUFFIX yum-plugin-fastestmirror.noarch yum-plugin-priorities.noarch
			# git.$OS_SUFFIX : Fast Version Control System
			# memcached.$OS_SUFFIX : High Performance, Distributed Memory Object Cache
			# phpMyAdmin.noarch : Handle the administration of MySQL over the World Wide Web
			# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
			# yum-plugin-fastestmirror.noarch : Yum plugin which chooses fastest repository from a mirrorlist
			##yum-plugin-priorities.noarch : plugin to give priorities to packages from different repos
		fi
		yum $INSTALL_OPTION install mysql-server.$OS_SUFFIX nginx.$OS_SUFFIX_SPECIAL php-pecl-memcache.$OS_SUFFIX php-mysql.$OS_SUFFIX
		# mysql-server.$OS_SUFFIX : The MySQL server and related files
		# nginx.$OS_SUFFIX_SPECIAL : nginx is a high performance web server
		# php-pecl-memcache.$OS_SUFFIX : Extension to work with the Memcached caching daemon
		# php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases
	fi
	yum $INSTALL_OPTION install gcc-c++.$OS_SUFFIX ntp.$OS_SUFFIX php.$OS_SUFFIX php-devel.$OS_SUFFIX vim-enhanced.$OS_SUFFIX
	# gcc-c++.$OS_SUFFIX : C++ support for GCC
	##ntp.$OS_SUFFIX : The NTP daemon and utilities
	# php.$OS_SUFFIX : PHP scripting language for creating dynamic web sites
	# php-devel.$OS_SUFFIX : Files needed for building PHP extensions
	# vim-enhanced.$OS_SUFFIX : A version of the VIM editor which includes recent enhancements
fi

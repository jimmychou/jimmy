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

SOFTWARE=~/software
sudo chmod 755 /home/jimmychou
#	755是web目录可以访问的最低要求，不要再试图744等

#Nginx
sudo cp ~/workspace/jimmy/os/build/done/init.d/nginx /etc/init.d/
sudo cp ~/workspace/jimmy/os/build/done/init/nginx/local.conf /etc/ld.so.conf.d/
#	否则报错：error while loading shared libraries: libprofiler.so.0: cannot open shared object file: No such file or directory
sudo ldconfig -v
sudo groupadd nginx && sudo useradd -M -g nginx nginx
#	否则报错 nginx: [emerg] getpwnam("nginx") failed
#	相反的用法是： sudo userdel -r nginx ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel nginx
if [ ! -d "/var/cache/nginx" ]; then
	sudo mkdir -p /var/cache/nginx
fi
if [ ! -d "/etc/nginx/conf.d" ]; then
	sudo mkdir /etc/nginx/conf.d
fi
sudo cp ~/workspace/jimmy/os/extra.conf /etc/nginx/conf.d/
sudo cp ~/workspace/jimmy/os/build/done/conf/nginx/nginx.conf /etc/nginx/nginx.conf
sudo /etc/init.d/nginx start
sudo chkconfig --add nginx
sudo chkconfig nginx on
sudo ln -sf ~/workspace/ /usr/share/nginx/html/jimmychou

#HTTPD
sudo groupadd apache && sudo useradd -M -g apache apache
sudo cp ~/workspace/jimmy/os/build/done/conf/httpd/httpd.conf /etc/httpd/conf/
sudo cp ~/workspace/jimmy/os/build/done/init.d/httpd /etc/init.d/
if [ ! -d "/var/run/httpd" ]; then
	sudo mkdir /var/run/httpd
	sudo chown apache:root /var/run/httpd	#	否则	/etc/init.d/httpd stop	不能正常工作
fi
sudo /etc/init.d/httpd start
sudo chkconfig --add httpd
sudo chkconfig httpd on
sudo ln -sf ~/workspace/ /var/www/htdocs/jimmychou
sudo ln -sf $SOFTWARE/phpMyAdmin-4.0.4.1-all-languages/ ~/workspace/phpMyAdmin
cp ~/workspace/jimmy/os/build/done/conf/phpMyAdmin/config.inc.php ~/workspace/phpMyAdmin/

#MySQL
sudo groupadd mysql && sudo useradd -M -g mysql mysql
sudo mysql_install_db --user=mysql
sudo cp ~/workspace/jimmy/os/build/done/conf/mysql/my.cnf /etc/my.cnf
sudo cp ~/workspace/jimmy/os/build/done/init.d/mysqld /etc/init.d/mysqld
if [ ! -d "/var/run/mysqld" ]; then
	sudo mkdir /var/run/mysqld
	sudo chown mysql:root /var/run/mysqld	#	否则	/etc/init.d/mysqld stop	不能正常工作
fi
sudo /etc/init.d/mysqld start
sudo mysqladmin -u root -p password 'penny7531'	#	不用sudo居然报错：error: 'Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (13)'
	#	除非指定	-h	为	127.0.0.1，否则	mysql	-uroot	都会报上述错误，phpMyAdmin也是同样的道理
#sudo mysqladmin -u root -h localhost.localdomain -p password 'penny7531'	#	貌似比较奇怪的一种命令
sudo chkconfig --add mysqld
sudo chkconfig mysqld on

#PHP
#	/etc/init.d/php-fpm stop	不能工作跟	MySQL	不一样，是因为	php-fpm.conf	没有开启	pidfile
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php.ini /etc/ 
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php-fpm.conf /etc/
if [ ! -d "/var/log/php-fpm" ]; then
	sudo mkdir /var/log/php-fpm
fi
	#	否则会报错：failed to open error_log (/var/log/php-fpm/error.log): No such file or directory
#sudo groupadd apache && sudo useradd -M -g apache apache	#	否则启动时会报错：cannot get uid for user 'apache'
if [ ! -d "/etc/php.d" ]; then
	sudo mkdir /etc/php.d
fi
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php.d/* /etc/php.d/
sudo cp ~/workspace/jimmy/os/build/done/init.d/php-fpm /etc/init.d/
sudo /etc/init.d/php-fpm start
sudo chkconfig --add php-fpm
sudo chkconfig php-fpm on

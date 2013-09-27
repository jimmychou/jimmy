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

#sudo chmod 755 /home/jimmychou
#	755是web目录可以访问的最低要求，不要再试图744等


#Nginx
sudo cp ~/workspace/jimmy/os/build/done/init.d//nginx /etc/init.d/
sudo cp ~/workspace/jimmy/os/build/done/init/nginx/local.conf /etc/ld.so.conf.d/
#	否则报错：error while loading shared libraries: libprofiler.so.0: cannot open shared object file: No such file or directory
sudo ldconfig -v
sudo groupadd nginx && sudo useradd -M -g nginx nginx
#	否则报错 nginx: [emerg] getpwnam("nginx") failed
#	相反的用法是： sudo userdel -r nginx ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel nginx
sudo mkdir -p /var/cache/nginx
sudo mkdir /etc/nginx/conf.d
sudo cp ~/workspace/jimmy/os/extra.conf /etc/nginx/conf.d/
sudo cp ~/workspace/jimmy/os/build/done/conf/nginx/nginx.conf /etc/nginx/nginx.conf
sudo /etc/init.d/nginx start
sudo chkconfig --add nginx
sudo chkconfig nginx on
sudo ln -s ~/workspace/ /usr/share/nginx/html/jimmychou

#MySQL
sudo groupadd mysql && sudo useradd -M -g mysql mysql
sudo mysql_install_db --user=mysql
sudo cp ~/workspace/jimmy/os/build/done/conf/mysql/my.cnf /etc/my.cnf
sudo cp ~/workspace/jimmy/os/build/done/init.d/mysqld /etc/init.d/mysqld
sudo /etc/init.d/mysqld start
#mysqladmin -u root -p password 'penny7531'
#mysqladmin -u root -h localhost.localdomain -p password 'penny7531'	#	貌似比较奇怪的一种命令
sudo chkconfig --add mysqld
sudo chkconfig mysqld on

#PHP
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php.ini /etc/ 
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php-fpm.conf /etc/
sudo mkdir /etc/php.d
sudo cp ~/workspace/jimmy/os/build/done/conf/php/php.d/* /etc/php.d/
sudo cp ~/workspace/jimmy/os/build/done/init.d/php-fpm /etc/init.d/
#sudo /etc/init.d/php-fpm start
sudo /usr/sbin/php-fpm -y /etc/php-fpm.conf -g /var/run/php-fpm.pid
#sudo chkconfig --add php-fpm
#sudo chkconfig php-fpm on

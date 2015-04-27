#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
source ./release.sh
SOFTWARE=~/software
for i in $*; do 
	if [[ $i == "nginx" ]]; then
		#Nginx
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init.d/nginx /etc/init.d/
		#sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init/nginx/local.conf /etc/ld.so.conf.d/
			#	否则报错：error while loading shared libraries: libprofiler.so.0: cannot open shared object file: No such file or directory
		#sudo ldconfig -v
		#sudo groupadd nginx && sudo useradd -M -g nginx nginx
			#	否则报错 nginx: [emerg] getpwnam("nginx") failed
			#	相反的用法是： sudo userdel -r nginx ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel nginx
		#	后来发现不知什么时候似乎已经添加此	nginx	用户和用户组
		#if [ ! -d "/var/cache/nginx" ]; then
		#	sudo mkdir -p /var/cache/nginx
		#fi
		#	后来发现竟然不需要创建以上目录
		if [ ! -d "/etc/nginx/conf.d" ]; then
			sudo mkdir /etc/nginx/conf.d
		fi
		#sudo cp ~/workspace/jimmy/os/extra.conf /etc/nginx/conf.d/
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/nginx/nginx.conf /etc/nginx/nginx.conf
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/nginx/conf.d/centos_6.conf /etc/nginx/conf.d/
		if [[ -z `getsebool httpd_read_user_content | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_read_user_content 1
		fi
		if [[ -z `getsebool httpd_enable_homedirs | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_enable_homedirs 1
		fi
		sudo chmod 755 /home/jimmychou
#		755是web目录可以访问的最低要求，不要再试图744等
		sudo /etc/init.d/nginx start
		sudo chkconfig --add nginx
		sudo chkconfig nginx on
		#sudo ln -sf ~/workspace/ /usr/share/nginx/html/jimmychou
		#sudo ln -sf $SOFTWARE/phpMyAdmin-4.0.4.1-all-languages/ ~/workspace/phpMyAdmin
		#if [ -d "~/workspace/phpMyAdmin" ]; then
			#cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/phpMyAdmin/config.inc.php ~/workspace/phpMyAdmin/
		#fi
	elif [[ $i == "httpd" ]]; then
		#HTTPD
		if [ ! -d "/etc/httpd/conf.d" ]; then
			sudo mkdir -p /etc/httpd/conf.d
		fi
		if [ ! -d "/etc/httpd/logs" ]; then
			sudo ln -sf /var/log/httpd /etc/httpd/logs
		else
			sudo rm -fr /etc/httpd/logs
			sudo ln -sf /var/log/httpd /etc/httpd/logs
		fi
		if [ ! -d "/etc/httpd/modules" ]; then
			sudo ln -sf /usr/lib/httpd/modules /etc/httpd/modules
		fi
		if [ ! -d "/etc/httpd/run" ]; then
			sudo ln -sf /var/run /etc/httpd/run
		fi
		if [ ! -d "/var/log/httpd" ];then
			sudo mkdir -p /var/log/httpd
			sudo chmod 700 /var/log/httpd
		fi
		#if [ ! -d "/var/www/html" ]; then
		#	sudo mkdir -p /var/www/html
		#fi
		sudo groupadd apache && sudo useradd -M -g apache apache
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/httpd/httpd.conf /etc/httpd/conf/
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init.d/httpd /etc/init.d/
			#	以下后来不需要了，按照标准yum安装的目录，从	/var/run/httpd/httpd.pid	移到了	/var/run/httpd.pid
		#if [ ! -d "/var/run/httpd" ]; then
		#	sudo mkdir /var/run/httpd
		#	sudo chown apache:root /var/run/httpd	#	否则	/etc/init.d/httpd stop	不能正常工作
		#fi
		sudo /etc/init.d/httpd start
		sudo chkconfig --add httpd
		sudo chkconfig httpd on
		sudo ln -sf ~/workspace/ /var/www/htdocs/jimmychou
		sudo ln -sf $SOFTWARE/phpMyAdmin-4.0.4.1-all-languages/ ~/workspace/phpMyAdmin
		if [ -d "~/workspace/phpMyAdmin" ];then
			cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/phpMyAdmin/config.inc.php ~/workspace/phpMyAdmin/
		fi
	elif [[ $i == "mysql" ]]; then
		#MySQL
		sudo groupadd mysql && sudo useradd -M -g mysql mysql
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/mysql/* /etc/
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init.d/mysqld /etc/init.d/
		if [ ! -d "/var/run/mysqld" ]; then
			sudo mkdir /var/run/mysqld
			sudo chown mysql:root /var/run/mysqld	#	否则	/etc/init.d/mysqld stop	不能正常工作
		fi
		for sub in default master slave slave_a slave_b; do
			data_dir=/var/lib/mysql_$sub
			config_file=/etc/my_$sub.cnf
			if [[ $sub == "default" ]]; then
				data_dir=/var/lib/mysql
				config_file=/etc/my.cnf
			fi
			if [ ! -d $data_dir ]; then
				sudo mysql_install_db --defaults-file=$config_file --user=mysql
			fi
		done
		sudo mysqld_multi --defaults-file=/etc/my_multi.cnf --verbose start 1-4
		for sub in ndb_a ndb_b api_a api_b; do
			#	todo
			echo $sub
		done
		#sudo /etc/init.d/mysqld start
		#sudo mysqladmin -u root -p password 'penny7531'	#	不用sudo居然报错：error: 'Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (13)'
			#	除非指定	-h	为	127.0.0.1，否则	mysql	-uroot	都会报上述错误，phpMyAdmin也是同样的道理
		#sudo mysqladmin -u root -h localhost.localdomain -p password 'penny7531'	#	貌似比较奇怪的一种命令
		#sudo chkconfig --add mysqld
		#sudo chkconfig mysqld on
	elif [[ $i == "php" ]]; then
		#PHP
		#/etc/init.d/php-fpm stop	不能工作跟	MySQL	不一样，是因为	php-fpm.conf	没有开启	pidfile
		sudo groupadd nginx && sudo useradd -M -g nginx nginx
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/php/php.ini /etc/ 
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/php/php-fpm.conf /etc/
		if [ ! -d "/var/log/php-fpm" ]; then
			sudo mkdir /var/log/php-fpm
		fi
			#	否则会报错：failed to open error_log (/var/log/php-fpm/error.log): No such file or directory
		#sudo groupadd apache && sudo useradd -M -g apache apache	#	否则启动时会报错：cannot get uid for user 'apache'
		if [ ! -d "/etc/php.d" ]; then
			sudo mkdir /etc/php.d
		fi
		#sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/conf/php/php.d/* /etc/php.d/
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init.d/php-fpm /etc/init.d/
		if [[ -z `getsebool httpd_read_user_content | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_read_user_content 1
		fi
		if [[ -z `getsebool httpd_enable_homedirs | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_enable_homedirs 1
		fi
		sudo chmod 755 /home/jimmychou
#		755是web目录可以访问的最低要求，不要再试图744等
		sudo /etc/init.d/php-fpm start
		sudo chkconfig --add php-fpm
		sudo chkconfig php-fpm on
	elif [[ $i == "memcached" ]]; then
		sudo groupadd memcached && sudo useradd -M -g memcached memcached
		sudo cp ~/workspace/jimmy/os/centos/build/build_as_system/init.d/memcached /etc/init.d/
		if [ ! -d "/var/run/memcached" ]; then
			sudo mkdir /var/run/memcached
		fi
		sudo /etc/init.d/memcached start
		sudo chkconfig --add memcached
		sudo chkconfig memcached on
	fi
done

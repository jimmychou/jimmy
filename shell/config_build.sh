#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
source ./release.sh
SOFTWARE=~/software
for i in $*; do 
	if [[ $i =~ ^nginx ]]; then
		#	Nginx
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init.d/nginx /etc/init.d/
		#sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init/nginx/local.conf /etc/ld.so.conf.d/
			#	否则报错：error while loading shared libraries: libprofiler.so.0: cannot open shared object file: No such file or directory
		#sudo ldconfig -v
			#	自从	gperftools	的	--prefix	不是	/usr/local	下之后，不再需要上面两条语句
		if id -u nginx >/dev/null 2>&1; then
		        echo "nginx用户已存在"
		else
			sudo groupadd nginx && sudo useradd -M -g nginx nginx
			#	否则报错 nginx: [emerg] getpwnam("nginx") failed
			#	相反的用法是： sudo userdel -r nginx ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel nginx
		fi
			#	后来发现不知什么时候似乎已经添加此	nginx	用户和用户组
		if [ ! -d "/var/cache/nginx" ]; then
			sudo mkdir -p /var/cache/nginx
		fi
			#	后来发现竟然不需要创建以上目录
		if [ ! -d "/etc/nginx/conf.d" ]; then
			sudo mkdir /etc/nginx/conf.d
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/nginx.conf /etc/nginx/nginx.conf
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$i/common/conf.d/centos_6.conf /etc/nginx/conf.d/
		if [[ -z `getsebool httpd_read_user_content | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_read_user_content 1
		fi
		if [[ -z `getsebool httpd_enable_homedirs | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_enable_homedirs 1
		fi
		sudo chmod 755 /home/jimmychou
			#	755是web目录可以访问的最低要求，不要再试图744等
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		if [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "7" ]]; then
				sudo systemctl restart nginx
			else
				sudo /etc/init.d/nginx restart
			fi
		else
			sudo /etc/init.d/nginx restart
		fi
		sudo chkconfig --add nginx
		sudo chkconfig nginx on
		#sudo ln -sf ~/workspace/ /usr/share/nginx/html/jimmychou
		#sudo ln -sf $SOFTWARE/phpMyAdmin-4.0.4.1-all-languages/ ~/workspace/phpMyAdmin
		#if [ -d "~/workspace/phpMyAdmin" ]; then
			#cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/phpMyAdmin/config.inc.php ~/workspace/phpMyAdmin/
		#fi
	elif [[ $i =~ ^httpd ]]; then
		#	Httpd
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
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
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/httpd/httpd.conf /etc/httpd/conf/
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init.d/httpd /etc/init.d/
			#	以下后来不需要了，按照标准yum安装的目录，从	/var/run/httpd/httpd.pid	移到了	/var/run/httpd.pid
		#if [ ! -d "/var/run/httpd" ]; then
		#	sudo mkdir /var/run/httpd
		#	sudo chown apache:root /var/run/httpd	
				#	否则	/etc/init.d/httpd stop	不能正常工作
		#fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		sudo /etc/init.d/httpd restart
		sudo chkconfig --add httpd
		sudo chkconfig httpd on
		sudo ln -sf ~/workspace/ /var/www/htdocs/jimmychou
		sudo ln -sf $SOFTWARE/phpMyAdmin-4.0.4.1-all-languages/ ~/workspace/phpMyAdmin
		if [ -d "~/workspace/phpMyAdmin" ];then
			cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/phpMyAdmin/config.inc.php ~/workspace/phpMyAdmin/
		fi
	elif [[ $i =~ ^mysql ]]; then
		#	MySQL
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		if id -u mysql >/dev/null 2>&1; then
		        echo "mysql用户已存在"
		else
			sudo groupadd mysql && sudo useradd -M -g mysql mysql
			#	相反的用法是： sudo userdel -r mysql ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel mysql
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$i/common/conf/* /etc/
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init.d/* /etc/init.d/
		if [ ! -d "/var/run/mysqld" ]; then
			sudo mkdir /var/run/mysqld
			sudo chown mysql:root /var/run/mysqld
				#	否则	/etc/init.d/mysqld stop	不能正常工作
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		BUILD_HOST=build.$OS_DIR.jimmychou.com
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
			sudo mysqld_safe --defaults-file=$config_file &
			sleep 10s
				#	避免服务未启动就执行	mysqladmin	命令
				#	/usr/bin/mysqladmin -u root password 'new-password'
				#	/usr/bin/mysqladmin -u root -h localhost.localdomain password 'new-password'
			mysqladmin --defaults-file=$config_file -u root password 'zhouxiaomin123'
			#mysqladmin --defaults-file=$config_file -u root -h localhost password 'zhouxiaomin123'
			#mysqladmin --defaults-file=$config_file -u root -h '192.168.%.%' password 'zhouxiaomin123'
			#mysqladmin --defaults-file=$config_file -u root -h localhost.localdomain password 'zhouxiaomin123'
			#mysqladmin --defaults-file=$config_file -u root -h $BUILD_HOST password 'zhouxiaomin123'
		done
		#sudo mysqld_multi --defaults-file=/etc/my_multi.cnf --verbose start 1-4
			#	设定密码与my_multi.cnf中密码相悖
		for sub in ndb_a ndb_b api_a api_b; do
			#	@todo:	NDB	Cluster	Service
			echo $sub
		done
		#sudo /etc/init.d/mysqld start
			#	有了	mysqld_multi	之后就弃用了
		#sudo mysqladmin -u root -p password 'zhouxiaomin123'
			#	不用sudo居然报错：error: 'Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (13)'
			#	除非指定	-h	为	127.0.0.1，否则	mysql	-uroot	都会报上述错误，phpMyAdmin也是同样的道理
		#sudo mysqladmin -u root -h localhost.localdomain -p password 'zhouxiaomin123'	#	貌似比较奇怪的一种命令
		sudo chkconfig --add mysqld
		sudo chkconfig mysqld on
	elif [[ $i =~ ^php- || $i == 'php' ]]; then
		#	避免	phpMyAdmin	走此分支
		#	PHP
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		FIRST_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $1}'`
		SECOND_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $2}'`
		THIRD_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $3}'`
		if id -u nginx >/dev/null 2>&1; then
		        echo "nginx用户已存在"
		else
			sudo groupadd nginx && sudo useradd -M -g nginx nginx
			#	相反的用法是： sudo userdel -r nginx ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel nginx
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/php.ini /etc/ 
		if [ ! -d "/etc/php.d" ]; then
			sudo mkdir /etc/php.d
		fi
		#sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/php.d/* /etc/php.d/
		if [[ $FIRST_SOFT_VERSION -lt 5 ]]; then
			echo php-5.3.3	之前的版本没有	php-fpm
			php-cgi -b 127.0.0.1:9000 &
			exit
		elif [[ $FIRST_SOFT_VERSION -eq 5 ]]; then
			if [[ $SECOND_SOFT_VERSION -lt 3 ]]; then
				echo php-5.3.3	之前的版本没有	php-fpm
				php-cgi -b 127.0.0.1:9000 &
				exit
			elif [[ $SECOND_SOFT_VERSION -eq 3 && $THIRD_SOFT_VERSION -lt 3 ]]; then
				echo php-5.3.3	之前的版本没有	php-fpm
				php-cgi -b 127.0.0.1:9000 &
				exit
			fi
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/conf/php-fpm.conf /etc/
		if [ ! -d "/var/log/php-fpm" ]; then
			sudo mkdir /var/log/php-fpm
		fi
			#	否则会报错：failed to open error_log (/var/log/php-fpm/error.log): No such file or directory
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init.d/php-fpm /etc/init.d/
		if [[ -z `getsebool httpd_read_user_content | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_read_user_content 1
		fi
		if [[ -z `getsebool httpd_enable_homedirs | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_enable_homedirs 1
		fi
		sudo chmod 755 /home/jimmychou
			#	755是web目录可以访问的最低要求，不要再试图744等
		#/etc/init.d/php-fpm stop
			#	不能工作跟	MySQL	不一样，是因为	php-fpm.conf	没有开启	pidfile
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		sudo /etc/init.d/php-fpm restart
		sudo chkconfig --add php-fpm
		sudo chkconfig php-fpm on
	elif [[ $i =~ ^memcached ]]; then
		#	Memcached
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		if id -u memcached >/dev/null 2>&1; then
		        echo "memcached用户已存在"
		else
			sudo groupadd memcached && sudo useradd -M -g memcached memcached
			#	相反的用法是： sudo userdel -r memcached ## 一般情况下，如此删除用户后，连组也删除了	sudo groupdel memcached
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_NAME/$SOFT_VERSION/init.d/memcached /etc/init.d/
		if [ ! -d "/var/run/memcached" ]; then
			sudo mkdir /var/run/memcached
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		sudo /etc/init.d/memcached restart
		sudo chkconfig --add memcached
		sudo chkconfig memcached on
	elif [[ $i =~ ^phpMyAdmin ]]; then
		#	phpMyAdmin
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		if [[ $PrimaryVersion == "5" ]]; then
			SOFT_LOWER=`echo $SOFT_NAME | tr '[A-Z]' '[a-z]'`
				#       CentOS5 的      bash    版本为3，declare        命令不支持大小写转换，需要      bash4   支持
		else
			declare -l SOFT_LOWER=$SOFT_NAME
		fi
		cp ~/workspace/jimmy/os/$OS_DIR/build/done/$SOFT_LOWER/$SOFT_VERSION/conf/config.inc.php ~/workspace/$SOFT_LOWER/
		#	httpd_can_network_connect	需要么？貌似不同系统需求不同
		if [[ -z `getsebool httpd_can_network_connect_db | grep '\--> on'` ]]; then
			sudo setsebool -P httpd_can_network_connect_db 1
		fi
		sudo cp ~/workspace/jimmy/os/$OS_DIR/hosts /etc/
		mysql --defaults-file=/etc/my.cnf -u root -p < ~/workspace/phpmyadmin/examples/create_tables.sql
		sudo /etc/init.d/mysqld restart
	fi
done

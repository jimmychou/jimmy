#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
source ./release.sh
SOFTWARE=~/software
for i in $*; do 
	if [[ $i =~ ^gperftools ]]; then
		#	Nginx	的	google_perftools	模块
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && sudo ldconfig -v
	elif [[ $i =~ ^nginx ]]; then
		#	Nginx
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && sudo ldconfig -v
		if [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				sudo yum $INSTALL_OPTION install gd.$OS_SUFFIX geoip.$OS_SUFFIX
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo yum $INSTALL_OPTION install libxslt.$OS_SUFFIX gd.$OS_SUFFIX geoip.$OS_SUFFIX
			fi
		fi
	elif [[ $i =~ ^httpd ]]; then
		#	Httpd
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && sudo ldconfig -v
	elif [[ $i =~ ^mysql ]]; then
		#	MySQL
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			fi
		fi
		if [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "7" ]]; then
				if [[ $OS_SUFFIX == "x86_64" ]]; then
					sudo ln -sf /usr/lib64/libssl.so.1.0.1e /usr/lib64/libssl.so && sudo ln -sf /usr/lib64/libcrypto.so.1.0.1e /usr/lib64/libcrypto.so && sudo yum $INSTALL_OPTION install ncurses-devel.$OS_SUFFIX
				fi
			fi
		fi
		cd ~ && cp -r $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ~/ && rm -fr $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && cd $SOFTWARE && unzip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && cd ~ && sudo ldconfig -v && cd ~ && rm -fr $SOFTWARE && ln -sf /mnt/hgfs/software/ $SOFTWARE
	elif [[ $i =~ ^php- || $i == 'php' ]]; then
		#	避免	phpMyAdmin	走此分支
		#	PHP
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && sudo ldconfig -v
		if [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				sudo yum $INSTALL_OPTION install gmp.$OS_SUFFIX libmcrypt.$OS_SUFFIX
				#	libmcrypt	是在配置完成后需要
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo yum $INSTALL_OPTION install libevent.$OS_SUFFIX libmcrypt.$OS_SUFFIX
				#	libmcrypt	是在配置完成后需要
			elif [[ $PrimaryVersion == "7" ]]; then
				sudo yum $INSTALL_OPTION install t1lib.$OS_SUFFIX gd.$OS_SUFFIX
			fi
		fi
		FIRST_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $1}'`
		SECOND_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $2}'`
		THIRD_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $3}'`
		if [[ $FIRST_SOFT_VERSION -lt 5 ]]; then
			echo php-5.3.3	之前的版本没有	php-fpm
			sudo cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION/sapi/cgi/php /usr/bin/php-cgi
			exit
		elif [[ $FIRST_SOFT_VERSION -eq 5 ]]; then
			if [[ $SECOND_SOFT_VERSION -lt 3 ]]; then
				echo php-5.3.3	之前的版本没有	php-fpm
				sudo cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION/sapi/cgi/php /usr/bin/php-cgi
				exit
			elif [[ $SECOND_SOFT_VERSION -eq 3 && $THIRD_SOFT_VERSION -lt 3 ]]; then
				echo php-5.3.3	之前的版本没有	php-fpm
				sudo cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION/sapi/cgi/php /usr/bin/php-cgi
				exit
			fi
		fi
	elif [[ $i =~ ^memcached ]]; then
		#	Memcached
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && sudo ldconfig -v
	elif [[ $i =~ ^phpMyAdmin ]]; then
		#	phpMyAdmin
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION-all-languages.zip
		SOFT_INSTALL_DIR=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION-all-languages
		if [ ! -d $SOFT_INSTALL_DIR ]; then
			echo 安装文件夹不存在，需要解压安装压缩包
			if [ ! -f $SOFT_ZIP ]; then
				echo 安装压缩包不存在
				exit
			else
				echo 开始解压安装压缩包
				cd $SOFTWARE && unzip $SOFT_ZIP
			fi
		fi
		if [[ $PrimaryVersion == "5" ]]; then
			SOFT_LOWER=`echo $SOFT_NAME | tr '[A-Z]' '[a-z]'`
				#       CentOS5 的      bash    版本为3，declare        命令不支持大小写转换，需要      bash4   支持
		else
			declare -l SOFT_LOWER=$SOFT_NAME
		fi
		if [ ! -d ~/workspace/$SOFT_NAME-$SOFT_VERSION-all-languages ]; then
			cp -r $SOFT_INSTALL_DIR ~/workspace/
		fi
		if [ -d ~/workspace/$SOFT_LOWER ]; then
			rm -fr ~/workspace/$SOFT_LOWER
		fi
		ln -sf ~/workspace/$SOFT_NAME-$SOFT_VERSION-all-languages ~/workspace/$SOFT_LOWER
	fi
done

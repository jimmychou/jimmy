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
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.i386.rpm
				sudo yum $INSTALL_OPTION install gd.$OS_SUFFIX geoip.$OS_SUFFIX
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
				sudo yum $INSTALL_OPTION install gd.$OS_SUFFIX geoip.$OS_SUFFIX libxslt.$OS_SUFFIX
			fi
		fi
	elif [[ $i =~ ^httpd ]]; then
		#	Httpd
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
		cd ~ && cp -r $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip ~/ && rm -f $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.make_done.zip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip && cd $SOFTWARE && unzip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip && cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION && sudo make install && cd ~ && sudo ldconfig -v && rm -fr $SOFTWARE && ln -sf /mnt/hgfs/software/ $SOFTWARE
	elif [[ $i =~ ^php- || $i == 'php' ]]; then
		#	避免	phpMyAdmin	走此分支
		#	PHP
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.i386.rpm
				sudo yum $INSTALL_OPTION install gmp.$OS_SUFFIX libmcrypt.$OS_SUFFIX
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
				sudo yum $INSTALL_OPTION install libevent.$OS_SUFFIX libmcrypt.$OS_SUFFIX
			fi
		fi
	elif [[ $i =~ ^memcached ]]; then
		#	Memcached
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		SOFT_ZIP=$SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done.zip
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
		ln -sf ~/workspace/$SOFT_NAME-$SOFT_VERSION-all-languages ~/workspace/$SOFT_LOWER
	fi
done

#!/bin/bash
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'`
if [[ $OS == "Ubuntu" ]]; then
#	sudo apt-get install -y lsb g++
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version
else
#	sudo yum install -y redhat-lsb gcc-c++
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
if [ ! -d $SOFTWARE ];then
	mkdir $SOFTWARE
fi

# HTTPD编译

#HTTPDVERSION=2.4.6  # Some software is not compatible with the configure condition on CentOS 5.9
HTTPDVERSION=2.2.25
HTTPDSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f httpd-$HTTPDVERSION.$HTTPDSUFFIX ]; then
	wget http://mirror.bit.edu.cn/apache/httpd/httpd-$HTTPDVERSION.$HTTPDSUFFIX
fi
if [ ! -d httpd-$HTTPDVERSION ]; then
	tar -zvxf httpd-$HTTPDVERSION.$HTTPDSUFFIX
fi
cd $SOFTWARE/httpd-$HTTPDVERSION
if [[ $OS == "Ubuntu" ]]; then
	echo The Official Httpd on Ubuntu is configured as below:
elif [[ $OS == "CentOS" ]]; then
#	sudo yum install -y apr-util-devel.$OS_SUFFIX
	echo The Official Httpd on CentOS 5.9 is configured as below:
	echo The Current Httpd 2.2.25 on CentOS 5.9 is configured as below:
	./configure --prefix=/etc/httpd \
		--exec-prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/var/www \
		--datarootdir=/var/www/html \
		--libdir=/usr/lib/httpd/modules \
		--includedir=/usr/include/httpd \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--with-suexec-bin=/usr/sbin/suexec \
		--enable-so \
		--enable-info \
		--enable-rewrite=shared \
		--enable-speling=shared && make && sudo make install
fi

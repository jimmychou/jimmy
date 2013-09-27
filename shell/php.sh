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


# PHP编译
# 可用命令 php -i | grep configure 查看，但不知为何在Ubuntu下用 apt-get install 安装的不能看到

PHPVERSION=5.5.3
PHPSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f php-$PHPVERSION.$PHPSUFFIX ]; then
	wget http://cn2.php.net/get/php-$PHPVERSION.$PHPSUFFIX/from/this/mirror
fi
if [ ! -d php-$PHPVERSION ]; then
	tar -zvxf php-$PHPVERSION.$PHPSUFFIX && cd $SOFTWARE/php-$PHPVERSION
fi
cd $SOFTWARE/php-$PHPVERSION
if [[ $OS == "Ubuntu" ]]; then
	echo The Official PHP on Ubuntu is configured as below:
elif [[ $OS == "CentOS" ]]; then
#	sudo yum install -y bzip2-devel.$OS_SUFFIX curl-devel.$OS_SUFFIX gmp-devel.$OS_SUFFIX libc-client-devel.$OS_SUFFIX libmcrypt-devel.$OS_SUFFIX unixODBC-devel.$OS_SUFFIX postgresql-devel.$OS_SUFFIX sqlite-devel.$OS_SUFFIX aspell-devel.$OS_SUFFIX net-snmp-devel.$OS_SUFFIX
if [ ! -d "/etc/php.d" ]; then
	mkdir /etc/php.d
fi
<<NOEFFECT
	echo The Official PHP 5.4.19 of Remi Repository on CentOS 5.9 is configured as below:
	./configure --build=i386-redhat-linux-gnu \
		--host=i386-redhat-linux-gnu \
		--target=i386-redhat-linux-gnu \
		--program-prefix= \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--sysconfdir=/etc \
		--datadir=/usr/share \
		--includedir=/usr/include \
		--libdir=/usr/lib \
		--libexecdir=/usr/libexec \
		--localstatedir=/var \
		--sharedstatedir=/usr/com \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--cache-file=../config.cache \
		--with-libdir=lib \
		--with-config-file-path=/etc \
		--with-config-file-scan-dir=/etc/php.d \
		--disable-debug \
		--with-pic \
		--disable-rpath \
		--without-pear \
		--with-bz2 \
		--with-curl \
		--with-exec-dir=/usr/bin \
		--with-freetype-dir=/usr \
		--with-png-dir=/usr \
		--enable-gd-native-ttf \
		--without-gdbm \
		--with-gettext \
		--with-gmp \
		--with-iconv \
		--with-jpeg-dir=/usr \
		--with-openssl \
		--with-png \
		--with-pspell \
		--with-expat-dir=/usr \
		--with-pcre-regex=/usr \
		--with-zlib \
		--with-layout=GNU \
		--enable-exif \
		--enable-ftp \
		--enable-magic-quotes \
		--enable-sockets \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-sysvmsg \
		--enable-track-vars \
		--enable-trans-sid \
		--enable-yp \
		--enable-wddx \
		--with-kerberos \
		--enable-ucd-snmp-hack \
		--with-unixODBC=shared,/usr \
		--enable-memory-limit \
		--enable-shmop \
		--enable-calendar \
		--enable-dbx \
		--enable-dio \
		--with-mime-magic=/usr/share/file/magic.mime \
		--without-sqlite \
		--with-libxml-dir=/usr \
		--with-xml \
		--with-system-tzdata \
		--enable-force-cgi-redirect \
		--enable-pcntl \
		--with-imap=shared \
		--with-imap-ssl \
		--enable-mbstring=shared \
		--enable-mbstr-enc-trans \
		--enable-mbregex \
		--with-ncurses=shared \
		--with-gd=shared \
		--enable-bcmath=shared \
		--enable-dba=shared \
		--with-db4=/usr \
		--with-xmlrpc=shared \
		--with-ldap=shared \
		--with-ldap-sasl \
		--with-mysql=shared,/usr \
		--with-mysqli=shared,/usr/lib/mysql/mysql_config \
		--enable-dom=shared \
		--with-dom-xslt=/usr \
		--with-dom-exslt=/usr \
		--with-pgsql=shared \
		--with-snmp=shared,/usr \
		--enable-soap=shared \
		--with-xsl=shared,/usr \
		--enable-xmlreader=shared \
		--enable-xmlwriter=shared \
		--enable-fastcgi \
		--enable-pdo=shared \
		--with-pdo-odbc=shared,unixODBC,/usr \
		--with-pdo-mysql=shared,/usr/lib/mysql/mysql_config \
		--with-pdo-pgsql=shared,/usr \
		--with-pdo-sqlite=shared,/usr \
		--enable-dbase=shared
NOEFFECT
<<NOEFFECT
	echo The Official PHP on CentOS 6.0 is configured as below:
	./configure --build=i386-redhat-linux-gnu \
		--host=i386-redhat-linux-gnu \
		--target=i686-redhat-linux-gnu \
		--program-prefix= \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--sysconfdir=/etc \
		--datadir=/usr/share \
		--includedir=/usr/include \
		--libdir=/usr/lib \
		--libexecdir=/usr/libexec \
		--localstatedir=/var \
		--sharedstatedir=/var/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--cache-file=../config.cache \
		--with-libdir=lib \
		--with-config-file-path=/etc \
		--with-config-file-scan-dir=/etc/php.d \
		--disable-debug \
		--with-pic \
		--disable-rpath \
		--without-pear \
		--with-bz2 \
		--with-exec-dir=/usr/bin \
		--with-freetype-dir=/usr \
		--with-png-dir=/usr \
		--with-xpm-dir=/usr \
		--enable-gd-native-ttf \
		--without-gdbm \
		--with-gettext \
		--with-gmp \
		--with-iconv \
		--with-jpeg-dir=/usr \
		--with-openssl \
		--with-pcre-regex=/usr \
		--with-zlib \
		--with-layout=GNU \
		--enable-exif \
		--enable-ftp \
		--enable-magic-quotes \
		--enable-sockets \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-sysvmsg \
		--with-kerberos \
		--enable-ucd-snmp-hack \
		--enable-shmop \
		--enable-calendar \
		--without-sqlite \
		--with-libxml-dir=/usr \
		--enable-xml \
		--with-system-tzdata \
		--enable-force-cgi-redirect \
		--enable-pcntl \
		--with-imap=shared \
		--with-imap-ssl \
		--enable-mbstring=shared \
		--enable-mbregex \
		--with-gd=shared \
		--enable-bcmath=shared \
		--enable-dba=shared \
		--with-db4=/usr \
		--with-xmlrpc=shared \
		--with-ldap=shared \
		--with-ldap-sasl \
		--with-mysql=shared,/usr \
		--with-mysqli=shared,/usr/lib/mysql/mysql_config \
		--enable-dom=shared \
		--with-pgsql=shared \
		--enable-wddx=shared \
		--with-snmp=shared,/usr \
		--enable-soap=shared \
		--with-xsl=shared,/usr \
		--enable-xmlreader=shared \
		--enable-xmlwriter=shared \
		--with-curl=shared,/usr \
		--enable-fastcgi \
		--enable-pdo=shared \
		--with-pdo-odbc=shared,unixODBC,/usr \
		--with-pdo-mysql=shared,/usr/lib/mysql/mysql_config \
		--with-pdo-pgsql=shared,/usr \
		--with-pdo-sqlite=shared,/usr \
		--with-sqlite3=shared,/usr \
		--enable-json=shared \
		--enable-zip=shared \
		--without-readline \
		--with-libedit \
		--with-pspell=shared \
		--enable-phar=shared \
		--with-tidy=shared,/usr \
		--enable-sysvmsg=shared \
		--enable-sysvshm=shared \
		--enable-sysvsem=shared \
		--enable-posix=shared \
		--with-unixODBC=shared,/usr \
		--enable-fileinfo=shared \
		--enable-intl=shared \
		--with-icu-dir=/usr \
		--with-enchant=shared,/usr \
		--with-recode=shared,/usr
NOEFFECT
	echo The Current PHP 5.5.3 on CentOS 5.9 is configured as below:
	./configure --build=i386-redhat-linux-gnu \
		--host=i386-redhat-linux-gnu \
		--target=i386-redhat-linux-gnu \
		--program-prefix= \
		--prefix=/usr \
		--exec-prefix=/usr \
		--datadir=/usr/share/ \
		--sysconfdir=/etc \
		--cache-file=../config.cache \
		--with-libdir=lib \
		--with-config-file-path=/etc \
		--with-config-file-scan-dir=/etc/php.d \
		--disable-debug \
		--with-pic \
		--disable-rpath \
		--without-pear \
		--with-bz2 \
		--with-curl \
		--with-freetype-dir=/usr \
		--with-png-dir=/usr \
		--enable-gd-native-ttf \
		--without-gdbm \
		--with-gettext \
		--with-gmp \
		--with-iconv \
		--with-jpeg-dir=/usr \
		--with-openssl \
		--with-png-dir \
		--with-pspell \
		--with-libexpat-dir=/usr \
		--with-pcre-regex=/usr \
		--with-zlib \
		--with-layout=GNU \
		--enable-exif \
		--enable-ftp \
		--enable-sockets \
		--enable-sysvsem \
		--enable-sysvshm \
		--enable-sysvmsg \
		--enable-wddx \
		--with-kerberos \
		--with-unixODBC=shared,/usr \
		--enable-shmop \
		--enable-calendar \
		--without-sqlite3 \
		--with-libxml-dir=/usr \
		--enable-pcntl \
		--with-imap=shared \
		--with-imap-ssl \
		--enable-mbstring=shared \
		--enable-mbregex \
		--with-gd=shared \
		--enable-bcmath=shared \
		--enable-dba=shared \
		--with-db4=/usr \
		--with-xmlrpc=shared \
		--with-ldap=shared \
		--with-ldap-sasl \
		--with-mysql=shared,/usr \
		--with-mysqli=shared,/usr/bin/mysql_config \
		--with-pgsql=shared \
		--with-snmp=shared,/usr \
		--enable-soap=shared \
		--with-xsl=shared,/usr \
		--enable-xmlreader=shared \
		--enable-xmlwriter=shared \
		--enable-pdo=shared \
		--with-pdo-odbc=shared,unixODBC,/usr \
		--with-pdo-mysql=shared,/usr/bin/mysql_config \
		--with-pdo-pgsql=shared,/usr \
		--with-pdo-sqlite=shared,/usr \
		--with-mcrypt=shared,/usr \
		--enable-fpm && make && sudo make install
fi

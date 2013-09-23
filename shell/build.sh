#!/bin/bash
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'` 
if [[ $OS == "Ubuntu" ]]; then
	sudo apt-get install lsb g++
	#Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}'` #跟Version同，如此还会有空格，必须按如下执行
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	#len=`expr length $Codename`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version
else
	sudo yum install redhat-lsb gcc-c++
	OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}'` # 
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version 
fi
OS_SUFFIX=`uname -m` # uanme -p  uname -i
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

# Nginx模块 google_perftools_module

GPERFTOOLSVERSION=2.1
GPERFTOOLSSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f gperftools-$GPERFTOOLSVERSION.$GPERFTOOLSSUFFIX ]; then
	wget http://gperftools.googlecode.com/files/gperftools-$GPERFTOOLSVERSION.$GPERFTOOLSSUFFIX && tar -zvxf gperftools-$GPERFTOOLSVERSION.$GPERFTOOLSSUFFIX && cd $SOFTWARE/gperftools-$GPERFTOOLSVERSION && ./configure && make && sudo make install
fi

# Nginx编译

NGINXVERSION=1.4.1
NGINXSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f nginx-$NGINXVERSION.$NGINXSUFFIX ]; then
	wget http://nginx.org/download/nginx-$NGINXVERSION.$NGINXSUFFIX && tar -zvxf nginx-$NGINXVERSION.$NGINXSUFFIX && cd $SOFTWARE/nginx-$NGINXVERSION
	if [[ $OS == "Ubuntu" ]]; then
<<NOEFFECT
		echo The Official Nginx on Ubuntu 12.04 is configured as below:
		./configure --prefix=/etc/nginx \
			--conf-path=/etc/nginx/nginx.conf \
			--error-log-path=/var/log/nginx/error.log \
			--http-client-body-temp-path=/var/lib/nginx/body \
			--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
			--http-log-path=/var/log/nginx/access.log \
			--http-proxy-temp-path=/var/lib/nginx/proxy \
			--http-scgi-temp-path=/var/lib/nginx/scgi \
			--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
			--lock-path=/var/lock/nginx.lock \
			--pid-path=/var/run/nginx.pid \
			--with-debug \
			--with-http_addition_module \
			--with-http_dav_module \
			--with-http_geoip_module \
			--with-http_gzip_static_module \
			--with-http_image_filter_module \
			--with-http_realip_module \
			--with-http_stub_status_module \
			--with-http_ssl_module \
			--with-http_sub_module \
			--with-http_xslt_module \
			--with-ipv6 \
			--with-sha1=/usr/include/openssl \
			--with-md5=/usr/include/openssl \
			--with-mail \
			--with-mail_ssl_module \
			#以下四个模块是官方在Ubuntu下的编译nginx添加的第三方模块：
			#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-auth-pam \
			#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-echo \
			#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-upstream-fair \
			#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-dav-ext-module
NOEFFECT
<<NOEFFECT
		echo The Official Nginx on Ubuntu 13.04 is configured as below:
		./configure --prefix=/usr/share/nginx \
			--conf-path=/etc/nginx/nginx.conf \
			--error-log-path=/var/log/nginx/error.log \
			--http-client-body-temp-path=/var/lib/nginx/body \
			--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
			--http-log-path=/var/log/nginx/access.log \
			--http-proxy-temp-path=/var/lib/nginx/proxy \
			--http-scgi-temp-path=/var/lib/nginx/scgi \
			--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
			--lock-path=/var/lock/nginx.lock \
			--pid-path=/run/nginx.pid \
			--with-pcre-jit \
			--with-debug \
			--with-http_addition_module \
			--with-http_dav_module \
			--with-http_geoip_module \
			--with-http_gzip_static_module \
			--with-http_image_filter_module \
			--with-http_realip_module \
			--with-http_stub_status_module \
			--with-http_ssl_module \
			--with-http_sub_module \
			--with-http_xslt_module \
			--with-ipv6 \
			--with-sha1=/usr/include/openssl \
			--with-md5=/usr/include/openssl \
			--with-mail \
			--with-mail_ssl_module \
			#以下四个模块是官方在Ubuntu下的编译nginx添加的第三方模块：
			# --add-module=/build/buildd/nginx-1.2.6/debian/modules/nginx-auth-pam \
			# --add-module=/build/buildd/nginx-1.2.6/debian/modules/nginx-echo \
			# --add-module=/build/buildd/nginx-1.2.6/debian/modules/nginx-upstream-fair \
			# --add-module=/build/buildd/nginx-1.2.6/debian/modules/nginx-dav-ext-module
NOEFFECT
	elif [[ $OS == "CentOS" ]]; then
		sudo yum install pcre-devel.$OS_SUFFIX zlib-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX libxml2-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX
<<NOEFFECT
		echo The Official Nginx on CentOS 5.9 of Remi Repository is configured as below:
		./configure --prefix=/etc/nginx \
			--sbin-path=/usr/sbin/nginx \
			--conf-path=/etc/nginx/nginx.conf \
			--error-log-path=/var/log/nginx/error.log \
			--http-log-path=/var/log/nginx/access.log \
			--pid-path=/var/run/nginx.pid \
			--lock-path=/var/run/nginx.lock \
			--http-client-body-temp-path=/var/cache/nginx/client_temp \
			--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
			--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
			--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
			--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
			--user=nginx \
			--group=nginx \
			--with-http_ssl_module \
			--with-http_realip_module \
			--with-http_addition_module \
			--with-http_sub_module \
			--with-http_dav_module \
			--with-http_flv_module \
			--with-http_mp4_module \
			--with-http_gunzip_module \
			--with-http_gzip_static_module \
			--with-http_random_index_module \
			--with-http_secure_link_module \
			--with-http_stub_status_module \
			--with-mail \
			--with-mail_ssl_module \
			--with-file-aio \
			--with-ipv6 \
			--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
NOEFFECT
		echo The Current Nginx 1.4.1 on CentOS 5.9 is configured as below:
		./configure --prefix=/usr/share/nginx \
			--user=nginx \
			--group=nginx \
			--sbin-path=/usr/sbin/nginx \
			--conf-path=/etc/nginx/nginx.conf \
			--error-log-path=/var/log/nginx/error.log \
			--http-log-path=/var/log/nginx/access.log \
			--pid-path=/var/run/nginx.pid \
			--lock-path=/var/run/nginx.lock \
			--http-client-body-temp-path=/var/cache/nginx/client_temp \
			--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
			--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
			--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
			--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
			--with-http_addition_module \
			--with-http_degradation_module \
			--with-http_perl_module \
			--with-http_flv_module \
			--with-http_geoip_module \
			--with-google_perftools_module \
			--with-http_gzip_static_module \
			--with-http_gunzip_module \
			--with-http_image_filter_module \
			--with-http_mp4_module \
			--with-http_random_index_module \
			--with-http_realip_module \
			--with-http_secure_link_module \
			--with-http_ssl_module \
			--with-http_stub_status_module \
			--with-http_sub_module \
			--with-http_dav_module \
			--with-http_xslt_module \
			--with-ipv6 \
			--with-mail \
			--with-mail_ssl_module && make && sudo make install
	fi
fi

# HTTPD编译

#HTTPDVERSION=2.4.6  # Some software is not compatible with the configure condition on CentOS 5.9
HTTPDVERSION=2.2.25
HTTPDSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f httpd-$HTTPDVERSION.$HTTPDSUFFIX ]; then
	wget http://mirror.bit.edu.cn/apache/httpd/httpd-$HTTPDVERSION.$HTTPDSUFFIX && tar -zvxf httpd-$HTTPDVERSION.$HTTPDSUFFIX && cd $SOFTWARE/httpd-$HTTPDVERSION
	if [[ $OS == "Ubuntu" ]]; then
		echo The Official Httpd on Ubuntu is configured as below:
	elif [[ $OS == "CentOS" ]]; then
		sudo yum install apr-devel apr-util-devel
<<NOEFFECT
		echo The Official Httpd on CentOS 5.9 is configured as below:
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
			--with-apxs2=/usr/sbin/apxs \
			--without-mysql \
			--without-gd \
			--without-odbc \
			--disable-dom \
			--disable-dba \
			--without-unixODBC \
			--disable-pdo \
			--disable-xmlreader \
			--disable-xmlwriter
NOEFFECT
		echo The Current Httpd 2.2.25 on CentOS 5.9 is configured as below:
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
			--with-apxs2=/usr/sbin/apxs \
			--without-mysql \
			--without-gd \
			--without-odbc \
			--disable-dom \
			--disable-dba \
			--without-unixODBC \
			--disable-pdo \
			--disable-xmlreader \
			--disable-xmlwriter && make && sudo make install
	fi
fi

# MySQL编译，从5.5开始使用cmake来编译

#MYSQLBIGVERSION=5.6
#MYSQLVERSION=5.6.14

MYSQLBIGVERSION=5.0
MYSQLVERSION=5.0.96
MYSQLSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f mysql-$MYSQLVERSION.$MYSQLSUFFIX ]; then
	wget http://dev.mysql.com/get/Downloads/MySQL-$MYSQLBIGVERSION/mysql-$MYSQLVERSION.$MYSQLSUFFIX/from/http://cdn.mysql.com/ && tar -zvxf mysql-$MYSQLVERSION.$MYSQLSUFFIX && cd $SOFTWARE/mysql-$MYSQLVERSION
	if [[ $OS == "Ubuntu" ]]; then
		echo The Official MySQL on Ubuntu is configured as below:
	elif [[ $OS == "CentOS" ]]; then
<<NOEFFECT
		echo The Official MySQL on CentOS 5.9 is configured as below:
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
			--with-readline \
			--with-openssl \
			--without-debug \
			--enable-shared \
			--with-bench \
			--localstatedir=/var/lib/mysql \
			--with-unix-socket-path=/var/lib/mysql/mysql.sock \
			--with-mysqld-user=mysql \
			--with-extra-charsets=all \
			--with-innodb \
			--with-berkeley-db \
			--enable-community-features \
			--enable-local-infile \
			--enable-largefile \
			--enable-profiling \
			--enable-thread-safe-client \
			--disable-dependency-tracking \
			--with-named-thread-libs=-lpthread
			CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv"
			CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions"
			FFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables"
			build_alias=i386-redhat-linux-gnu \
			host_alias=i386-redhat-linux-gnu \
			target_alias=i386-redhat-linux-gnu
NOEFFECT
		echo The Current MySQL 5.0.96 on CentOS 5.9 is configured as below:
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
			--with-readline \
			--with-openssl \
			--without-debug \
			--enable-shared \
			--with-bench \
			--localstatedir=/var/lib/mysql \
			--with-unix-socket-path=/var/lib/mysql/mysql.sock \
			--with-mysqld-user=mysql \
			--with-extra-charsets=all \
			--with-innodb \
			--with-berkeley-db \
			--enable-community-features \
			--enable-local-infile \
			--enable-largefile \
			--enable-profiling \
			--enable-thread-safe-client \
			--disable-dependency-tracking \
			--with-named-thread-libs=-lpthread
			CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv"
			CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions"
			FFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables"
			build_alias=i386-redhat-linux-gnu \
			host_alias=i386-redhat-linux-gnu \
			target_alias=i386-redhat-linux-gnu && make && sudo make install
	fi
fi

# PHP编译
# 可用命令 php -i | grep configure 查看，但不知为何在Ubuntu下用 apt-get install 安装的不能看到

PHPVERSION=5.5.3
PHPSUFFIX=tar.gz
cd $SOFTWARE
if [ ! -f php-$PHPVERSION.$PHPSUFFIX ]; then
	wget http://cn2.php.net/get/php-$PHPVERSION.$PHPSUFFIX/from/this/mirror && tar -zvxf php-$PHPVERSION.$PHPSUFFIX && cd $SOFTWARE/php-$PHPVERSION
	if [[ $OS == "Ubuntu" ]]; then
		echo The Official PHP on Ubuntu is configured as below:
	elif [[ $OS == "CentOS" ]]; then
		sudo yum install bzip2-devel curl-devel gmp-devel libc-client-devel libmcrypt-devel unixODBC-devel postgresql-devel sqlite-devel aspell-devel net-snmp-devel
<<NOEFFECT
		echo The Official PHP on CentOS 5.9 is configured as below:
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
<<NOEFFECT
		echo The Local PHP 5.5.3 on CentOS 5.9 is configured as below:
		./configure --build=i386-redhat-linux-gnu \
			--host=i386-redhat-linux-gnu \
			--target=i386-redhat-linux-gnu \
			--program-prefix= \
			--prefix=/usr/local \
			--exec-prefix=/usr/local \
			--datadir=/usr/local/share/ \
			--cache-file=../config.cache \
			--with-libdir=lib \
			--with-config-file-path=/usr/local/etc \
			--with-config-file-scan-dir=/usr/local/etc/php.d \
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
			--with-mysqli=shared,/usr/lib/mysql/mysql_config \
			--with-pgsql=shared \
			--with-snmp=shared,/usr \
			--enable-soap=shared \
			--with-xsl=shared,/usr \
			--enable-xmlreader=shared \
			--enable-xmlwriter=shared \
			--enable-pdo=shared \
			--with-pdo-odbc=shared,unixODBC,/usr \
			--with-pdo-mysql=shared,/usr/lib/mysql/mysql_config \
			--with-pdo-pgsql=shared,/usr \
			--with-pdo-sqlite=shared,/usr \
			--with-mcrypt=shared,/usr \
			--enable-fpm
NOEFFECT
		echo The Current PHP 5.5.3 on CentOS 5.9 is configured as below:
		./configure --build=i386-redhat-linux-gnu \
			--host=i386-redhat-linux-gnu \
			--target=i386-redhat-linux-gnu \
			--program-prefix= \
			--prefix=/usr \
			--exec-prefix=/usr \
			--datadir=/usr/share/ \
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
fi

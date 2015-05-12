#!/bin/bash
if [ $# -le 0 ]; then
	echo You need specify one parameter at least!
	exit
fi
SCRIPT_ACTION=INSTALL_BUILD
source ./release.sh
SOFTWARE=~/software
SOFT_SUFFIX=tar.gz
if [ ! -d $SOFTWARE ];then
	mkdir $SOFTWARE
fi
for i in $*; do
	if [[ $i =~ ^libunwind ]]; then
		# libunwind编译，会对	x86_64	平台做一些多线程相关的优化
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition http://download.savannah.gnu.org/releases/$SOFT_NAME/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
		if [[ $OS_SUFFIX == "x86_64" ]]; then
			CFLAGS="-fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free"
			./configure --build=x86_64-redhat-linux-gnu \
				--host=x86_64-redhat-linux-gnu \
				--target=x86_64-redhat-linux-gnu \
				--program-prefix= \
				--prefix=/usr \
				--exec-prefix=/usr \
				--bindir=/usr/bin \
				--sbindir=/usr/sbin \
				--sysconfdir=/etc \
				--datadir=/usr/share \
				--includedir=/usr/include \
				--libdir=/usr/lib64 \
				--libexecdir=/usr/libexec \
				--localstatedir=/var \
				--sharedstatedir=/usr/com \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				build_alias=x86_64-redhat-linux-gnu \
				host_alias=x86_64-redhat-linux-gnu \
				target_alias=x86_64-redhat-linux-gnu
		else
			echo 32位系统不需要安装
		fi
		make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
	elif [[ $i =~ ^gperftools ]]; then
		# gperftools编译
		# Nginx模块 google_perftools_module	需要
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition http://gperftools.googlecode.com/files/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
		if [[ $OS_SUFFIX == "x86_64" ]]; then
			CFLAGS="-fno-builtin-malloc -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free"
			./configure --build=x86_64-redhat-linux-gnu \
				--host=x86_64-redhat-linux-gnu \
				--target=x86_64-redhat-linux-gnu \
				--program-prefix= \
				--prefix=/usr \
				--exec-prefix=/usr \
				--bindir=/usr/bin \
				--sbindir=/usr/sbin \
				--sysconfdir=/etc \
				--datadir=/usr/share \
				--includedir=/usr/include \
				--libdir=/usr/lib64 \
				--libexecdir=/usr/libexec \
				--localstatedir=/var \
				--sharedstatedir=/usr/com \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				--enable-frame-pointers \
				build_alias=x86_64-redhat-linux-gnu \
				host_alias=x86_64-redhat-linux-gnu \
				target_alias=x86_64-redhat-linux-gnu
		else
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
				build_alias=i386-redhat-linux-gnu \
				host_alias=i386-redhat-linux-gnu \
				target_alias=i386-redhat-linux-gnu
		fi
		make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
#	        sudo touch /etc/ld.so.conf.d/gperftools.conf && sudo echo '/usr/local/lib/' > /etc/ld.so.conf.d/gperftools.conf && sudo ldconfig -v
#	        以上echo语句即使是sudo也无权限写入文件
#	       	sudo cp /home/jimmychou/workspace/jimmy/os/centos/build/build_as_system/conf/nginx/gperftools.conf /etc/ld.so.conf.d/ && sudo ldconfig -v
#		有了	configure	条件后，无需上面这一步了
	elif [[ $i =~ ^nginx ]]; then
		# Nginx编译
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition http://nginx.org/download/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [[ $OS == "Ubuntu" ]]; then
			if [[ $Codename == "precise" ]]; then
				echo The Official $SOFT_NAME-1.1.19 on $OS $Version is configured as below:
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
			elif [[ $Codename == "raring" ]]; then
				echo The Official $SOFT_NAME on $OS $Version is configured as below:
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
			fi
		elif [[ $OS == "CentOS" ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				#sudo yum $INSTALL_OPTION install pcre-devel.$OS_SUFFIX zlib-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX libxml2-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX GeoIP-devel.$OS_SUFFIX
				sudo yum $INSTALL_OPTION install pcre-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX
				#	zlib-devel	libxml2-devel	不知何时已经安装上了，GeoIP-devel	和	geoip-devel	不是一个软件么？
<<NOEFFECT
				echo The Official $SOFT_NAME-1.8.0 on $OS $Version of Nginx Repository is configured as below:
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
					--with-http_auth_request_module \
					--with-mail \
					--with-mail_ssl_module \
					--with-file-aio \
					--with-ipv6 \
					--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
NOEFFECT
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				if [ $SOFT_VERSION == "1.0.14" ]; then
					./configure --prefix=/usr/share/nginx \
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
						--with-http_addition_module \
						--with-http_degradation_module \
						--with-http_perl_module \
						--with-http_flv_module \
						--with-http_geoip_module \
						--with-google_perftools_module \
						--with-http_gzip_static_module \
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
						--with-file-aio \
						--with-mail \
						--with-debug \
						--with-http_stub_status_module \
						--with-mail_ssl_module \
						--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
				elif [ $SOFT_VERSION == "1.4.1" ]; then
					./configure --prefix=/usr/share/nginx \
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
						--with-file-aio \
						--with-mail \
						--with-debug \
						--with-http_stub_status_module \
						--with-mail_ssl_module \
						--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
				fi
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo yum $INSTALL_OPTION install pcre-devel.$OS_SUFFIX zlib-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX libxml2-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX perl.$OS_SUFFIX perl-devel.$OS_SUFFIX perl-ExtUtils-Embed.$OS_SUFFIX
<<NOEFFECT
				echo The Official $SOFT_NAME-1.8.0 on $OS $Version of Nginx Repository is configured as below:
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
					--with-http_auth_request_module \
					--with-mail \
					--with-mail_ssl_module \
					--with-file-aio \
					--with-ipv6 \
					--with-http_spdy_module \
					--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
NOEFFECT
				if [ $SOFT_VERSION == "1.0.14" ]; then
					echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
					./configure --prefix=/usr/share/nginx \
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
						--with-http_addition_module \
						--with-http_degradation_module \
						--with-http_perl_module \
						--with-http_flv_module \
						--with-http_geoip_module \
						--with-google_perftools_module \
						--with-http_gzip_static_module \
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
						--with-file-aio \
						--with-mail \
						--with-debug \
						--with-http_stub_status_module \
						--with-mail_ssl_module \
						--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
				elif [ $SOFT_VERSION == "1.4.1" ]; then
					echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
					./configure --prefix=/usr/share/nginx \
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
						--with-file-aio \
						--with-mail \
						--with-debug \
						--with-http_stub_status_module \
						--with-mail_ssl_module \
						--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables'
				fi
			elif [[ $PrimaryVersion == "7" ]]; then
				#sudo yum $INSTALL_OPTION install pcre-devel.$OS_SUFFIX zlib-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX libxml2-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX GeoIP-devel.$OS_SUFFIX
				sudo yum $INSTALL_OPTION install pcre-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX#libxslt-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX geoip-devel.$OS_SUFFIX
				#	zlib-devel	libxml2-devel	不知何时已经安装上了，GeoIP-devel	和	geoip-devel	不是一个软件么？
<<NOEFFECT
				echo The Official $SOFT_NAME-1.8.0 on $OS $Version of Nginx Repository is configured as below:
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
					--with-http_auth_request_module \
					--with-mail \
					--with-mail_ssl_module \
					--with-file-aio \
					--with-ipv6 \
					--with-http_spdy_module \
					--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic'
NOEFFECT
				if [ $SOFT_VERSION == "1.0.14" ]; then
					echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
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
						--with-http_gzip_static_module \
						--with-http_random_index_module \
						--with-http_secure_link_module \
						--with-http_stub_status_module \
						--with-mail \
						--with-mail_ssl_module \
						--with-file-aio \
						--with-ipv6
						#--with-ipv6 \
						#--with-cc-opt='-O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic'
	#	编译报错不能解决，只能暂时注释掉
				fi
			fi
			make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		fi
	elif [[ $i =~ ^httpd ]]; then
		# HTTPD编译
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition http://mirror.bit.edu.cn/apache/httpd/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [[ $OS == "Ubuntu" ]]; then
			echo The Official $SOFT_NAME on $OS $Version is configured as below:
		elif [[ $OS == "CentOS" ]]; then
			sudo yum $INSTALL_OPTION install apr-util-devel.$OS_SUFFIX
			echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
			if [[ $PrimaryVersion == "5" ]]; then
				echo The Official $SOFT_NAME-2.2.3 on $OS $Version is configured as below:
				./configure --build=i386-redhat-linux-gnu \
					--host=i386-redhat-linux-gnu \
					--target=i386-redhat-linux-gnu \
					--prefix=/etc/httpd \
					--exec-prefix=/usr \
					--mandir=/usr/share/man \
					--datadir=/var/www \
					--datarootdir=/var/www/html \
					--libdir=/usr/lib \
					--includedir=/usr/include/httpd \
					--bindir=/usr/bin \
					--sbindir=/usr/sbin \
					--with-suexec-bin=/usr/sbin/suexec \
					--enable-so \
					--enable-info \
					--libexecdir=/usr/lib/httpd/modules \
					--sysconfdir=/etc/httpd/conf \
					--enable-rewrite=shared \
					--enable-speling=shared
			elif [[ $PrimaryVersion == "6" ]]; then
				echo The Official $SOFT_NAME-2.2.15 on $OS $Version is configured as below:
				./configure --build=i386-redhat-linux-gnu \
					--host=i386-redhat-linux-gnu \
					--target=i386-redhat-linux-gnu \
					--prefix=/etc/httpd \
					--exec-prefix=/usr \
					--mandir=/usr/share/man \
					--datadir=/var/www \
					--datarootdir=/var/www/html \
					--libdir=/usr/lib \
					--includedir=/usr/include/httpd \
					--bindir=/usr/bin \
					--sbindir=/usr/sbin \
					--with-suexec-bin=/usr/sbin/suexec \
					--enable-so \
					--enable-info \
					--libexecdir=/usr/lib/httpd/modules \
					--sysconfdir=/etc/httpd/conf \
					--enable-rewrite=shared \
					--enable-speling=shared
			fi
			make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		fi
	elif [[ $i =~ ^mysql ]]; then
		# MySQL编译，从5.5开始使用cmake来编译
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		FIRST_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $1}'`
		SECOND_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $2}'`
		THIRD_SOFT_VERSION=`echo $SOFT_VERSION | awk -F "." '{print $3}'`
		SOFT_BIGVERSION=$FIRST_SOFT_VERSION.$SECOND_SOFT_VERSION
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			#	SHELL的if语句，多条件使用要注意
			#if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX && ! -f index.html ]; then      #   NOT OK
			#if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX -a ! -f index.html ]; then      #   OK?
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ] && [ ! -f index.html ]; then   #   OK
				wget --content-disposition http://dev.mysql.com/get/Downloads/MySQL-$SOFT_BIGVERSION/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX/from/http://cdn.mysql.com/
			fi
			#if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX && -f index.html ]; then        #   NOT OK
			#if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX -a -f index.html ]; then        #   OK?
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ] && [ -f index.html ]; then     #   OK
				mv index.html $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			cd ~ && cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ~ && rm -fr $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX && cd $SOFTWARE
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			cd ~ && cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ~ && rm -fr $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && cd $SOFTWARE
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [[ $OS == "Ubuntu" ]]; then
			echo The Official $SOFT_NAME on $OS $Version is configured as below:
		elif [[ $OS == "CentOS" ]]; then
			sudo yum $INSTALL_OPTION install ncurses-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX
			if [[ $PrimaryVersion == "5" ]]; then
				sudo yum $INSTALL_OPTION install doxygen
				echo The Official $SOFT_NAME-5.0.95 on $OS $Version is configured as below:
#	奇怪的问题，注释在这里实在是太奇怪了
#SEND-PR: -*- send-pr -*-
#SEND-PR: Lines starting with `SEND-PR' will be removed automatically, as
#SEND-PR: will all comments (text enclosed in `<' and `>').
<<NOEFFECT
SEND-PR:
From: jimmychou
To: mysql@lists.mysql.com
Subject: [50 character or so descriptive subject here (for reference)]

>Description:
	<precise description of the problem (multiple lines)>
>How-To-Repeat:
	<code/input/activities to reproduce the problem (multiple lines)>
>Fix:
	<how to correct or work around the problem, if known (multiple lines)>

>Submitter-Id:	<submitter ID>
>Originator:	
>Organization:
 <organization of PR author (multiple lines)>
>MySQL support: [none | licence | email support | extended email support ]
>Synopsis:	<synopsis of the problem (one line)>
>Severity:	<[ non-critical | serious | critical ] (one line)>
>Priority:	<[ low | medium | high ] (one line)>
>Category:	mysql
>Class:		<[ sw-bug | doc-bug | change-request | support ] (one line)>
>Release:	mysql-5.0.95 (Source distribution)

>C compiler:    gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-54)
>C++ compiler:  g++ (GCC) 4.1.2 20080704 (Red Hat 4.1.2-54)
>Environment:
	<machine, os, target, libraries (multiple lines)>
System: Linux localhost.localdomain 2.6.18-404.el5 #1 SMP Tue Apr 7 12:42:23 EDT 2015 i686 i686 i386 GNU/Linux
Architecture: i686

Some paths:  /usr/bin/perl /usr/bin/make /usr/bin/gmake /usr/bin/gcc /usr/bin/cc
GCC: 使用内建 specs。
目标：i386-redhat-linux
配置为：../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --disable-plugin --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --with-cpu=generic --host=i386-redhat-linux
线程模型：posix
gcc 版本 4.1.2 20080704 (Red Hat 4.1.2-55)
Compilation info (call): CC=''  CFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv'  CXX=''  CXXFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions'  LDFLAGS=''  ASFLAGS=''
Compilation info (used): CC='gcc'  CFLAGS=' -DDBUG_OFF -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv  '  CXX='g++'  CXXFLAGS=' -DDBUG_OFF -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions   -fno-implicit-templates -fno-exceptions -fno-rtti'  LDFLAGS=' -rdynamic '  ASFLAGS=''
LIBC: 
lrwxrwxrwx 1 root root 11 04-16 18:37 /lib/libc.so.6 -> libc-2.5.so
-rwxr-xr-x 1 root root 1706208 01-28 03:04 /lib/libc-2.5.so
-rw-r--r-- 1 root root 3028546 01-28 01:33 /usr/lib/libc.a
-rw-r--r-- 1 root root 238 01-28 01:01 /usr/lib/libc.so
Configure command: ./configure '--build=i386-redhat-linux-gnu' '--host=i386-redhat-linux-gnu' '--target=i386-redhat-linux-gnu' '--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr' '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc' '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib' '--libexecdir=/usr/libexec' '--localstatedir=/var' '--sharedstatedir=/usr/com' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--with-readline' '--with-openssl' '--without-debug' '--enable-shared' '--with-bench' '--localstatedir=/var/lib/mysql' '--with-unix-socket-path=/var/lib/mysql/mysql.sock' '--with-mysqld-user=mysql' '--with-extra-charsets=all' '--with-innodb' '--with-berkeley-db' '--enable-community-features' '--enable-local-infile' '--enable-largefile' '--enable-profiling' '--enable-thread-safe-client' '--disable-dependency-tracking' '--with-named-thread-libs=-lpthread' 'CFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv' 'CXXFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions' 'FFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables' 'build_alias=i386-redhat-linux-gnu' 'host_alias=i386-redhat-linux-gnu' 'target_alias=i386-redhat-linux-gnu'
NOEFFECT
<<NOEFFECT
				echo The Official $SOFT_NAME-5.0.95 on $OS $Version is configured as below(translate from above):
				CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv"
				CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions"
				FFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables"
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
					--with-named-thread-libs=-lpthread \
					build_alias=i386-redhat-linux-gnu \
					host_alias=i386-redhat-linux-gnu \
					target_alias=i386-redhat-linux-gnu
NOEFFECT
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				if [[ $OS_SUFFIX != "x86_64" ]]; then
					CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv"
					CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions"
					FFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables"
				fi
				if [[ $SOFT_BIGVERSION == "5.0" ]]; then
					if [[ $SOFT_VERSION == "5.0.95" ]]; then
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
							--with-named-thread-libs=-lpthread \
							--with-blackhole-storage-engine \
							--with-example-storage-engine \
							--with-archive-storage-engine \
							--with-csv-storage-engine \
							--with-federated-storage-engine \
							--with-ndbcluster \
							--with-ndb-test \
							--with-ndb-docs \
							build_alias=i386-redhat-linux-gnu \
							host_alias=i386-redhat-linux-gnu \
							target_alias=i386-redhat-linux-gnu
					elif [[ $SOFT_VERSION == "5.0.96" ]]; then
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
							--with-named-thread-libs=-lpthread \
							--with-blackhole-storage-engine \
							--with-example-storage-engine \
							--with-archive-storage-engine \
							--with-csv-storage-engine \
							--with-federated-storage-engine \
							--with-ndbcluster \
							--with-ndb-test \
							--with-ndb-docs \
							build_alias=i386-redhat-linux-gnu \
							host_alias=i386-redhat-linux-gnu \
							target_alias=i386-redhat-linux-gnu
					fi
				fi
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo yum $INSTALL_OPTION install doxygen
				#	--with-ndb-docs 需要，configure   时不报错，但    make    时会报错
				echo The Official $SOFT_NAME-5.1.73 on $OS $Version is configured as below:
#	奇怪的问题，注释在这里实在是太奇怪了
#SEND-PR: -*- send-pr -*-
#SEND-PR: Lines starting with `SEND-PR' will be removed automatically, as
#SEND-PR: will all comments (text enclosed in `<' and `>').
<<NOEFFECT
SEND-PR:
From: jimmychou
To: mysql@lists.mysql.com
Subject: [50 character or so descriptive subject here (for reference)]

>Description:
	<precise description of the problem (multiple lines)>
>How-To-Repeat:
	<code/input/activities to reproduce the problem (multiple lines)>
>Fix:
	<how to correct or work around the problem, if known (multiple lines)>

>Submitter-Id:	<submitter ID>
>Originator:	
>Organization:
 <organization of PR author (multiple lines)>
>MySQL support: [none | licence | email support | extended email support ]
>Synopsis:	<synopsis of the problem (one line)>
>Severity:	<[ non-critical | serious | critical ] (one line)>
>Priority:	<[ low | medium | high ] (one line)>
>Category:	mysql
>Class:		<[ sw-bug | doc-bug | change-request | support ] (one line)>
>Release:	mysql-5.1.73 (Source distribution)

>C compiler:    gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-4)
>C++ compiler:  g++ (GCC) 4.4.7 20120313 (Red Hat 4.4.7-4)
>Environment:
	<machine, os, target, libraries (multiple lines)>
System: Linux localhost.localdomain 2.6.32-504.12.2.el6.i686 #1 SMP Wed Mar 11 19:05:53 UTC 2015 i686 i686 i386 GNU/Linux
Architecture: i686

Some paths:  /usr/bin/perl /usr/bin/make /usr/bin/gmake /usr/bin/gcc /usr/bin/cc
GCC: 使用内建 specs。
目标：i686-redhat-linux
配置为：../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre --enable-libgcj-multifile --enable-java-maintainer-mode --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libjava-multilib --with-ppl --with-cloog --with-tune=generic --with-arch=i686 --build=i686-redhat-linux
线程模型：posix
gcc 版本 4.4.7 20120313 (Red Hat 4.4.7-11) (GCC) 
Compilation info (call): CC='gcc'  CFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC'  CXX=''  CXXFLAGS='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC -felide-constructors -fno-rtti -fno-exceptions'  LDFLAGS=''  ASFLAGS=''
Compilation info (used): CC='gcc'  CFLAGS=' -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC   -DUNIV_LINUX -DUNIV_LINUX'  CXX='g++'  CXXFLAGS=' -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC -felide-constructors -fno-rtti -fno-exceptions   -fno-implicit-templates -fno-exceptions -fno-rtti'  LDFLAGS=' -rdynamic '  ASFLAGS=''
LIBC: 
lrwxrwxrwx. 1 root root 12 3月  20 06:48 /lib/libc.so.6 -> libc-2.12.so
-rwxr-xr-x. 1 root root 1902892 1月  28 03:11 /lib/libc-2.12.so
-rw-r--r--. 1 root root 238 1月  28 02:37 /usr/lib/libc.so
Configure command: ./configure  '--build=i386-redhat-linux-gnu' '--host=i386-redhat-linux-gnu' '--target=i686-redhat-linux-gnu' '--program-prefix=' '--prefix=/usr' '--exec-prefix=/usr' '--bindir=/usr/bin' '--sbindir=/usr/sbin' '--sysconfdir=/etc' '--datadir=/usr/share' '--includedir=/usr/include' '--libdir=/usr/lib' '--libexecdir=/usr/libexec' '--localstatedir=/var' '--sharedstatedir=/var/lib' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--with-readline' '--with-ssl=/usr' '--without-debug' '--enable-shared' '--with-embedded-server' '--localstatedir=/var/lib/mysql' '--with-unix-socket-path=/var/lib/mysql/mysql.sock' '--with-mysqld-user=mysql' '--with-extra-charsets=all' '--with-big-tables' '--with-pic' '--with-plugin-innobase' '--with-plugin-innodb_plugin' '--with-plugin-partition' '--enable-local-infile' '--enable-largefile' '--enable-thread-safe-client' '--disable-dependency-tracking' 'build_alias=i386-redhat-linux-gnu' 'host_alias=i386-redhat-linux-gnu' 'target_alias=i686-redhat-linux-gnu' 'CFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC' 'CXXFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC -felide-constructors -fno-rtti -fno-exceptions'
NOEFFECT
<<NOEFFECT
				echo The Official $SOFT_NAME-5.1.73 on $OS $Version is configured as below(translate from above):
				CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC"
				CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC -felide-constructors -fno-rtti -fno-exceptions"
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
					--with-readline \
					--with-ssl=/usr \
					--without-debug \
					--enable-shared \
					--with-embedded-server \
					--localstatedir=/var/lib/mysql \
					--with-unix-socket-path=/var/lib/mysql/mysql.sock \
					--with-mysqld-user=mysql \
					--with-extra-charsets=all \
					--with-big-tables \
					--with-pic \
					--with-plugin-innobase \
					--with-plugin-innodb_plugin \
					--with-plugin-partition \
					--enable-local-infile \
					--enable-largefile \
					--enable-thread-safe-client \
					--disable-dependency-tracking \
					build_alias=i386-redhat-linux-gnu \
					host_alias=i386-redhat-linux-gnu \
					target_alias=i686-redhat-linux-gnu
NOEFFECT
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				if [[ $SOFT_BIGVERSION == "5.0" ]]; then
					if [[ $OS_SUFFIX != "x86_64" ]]; then
						CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv"
						CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fno-rtti -fno-exceptions"
						FFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i386 -mtune=generic -fasynchronous-unwind-tables"
					fi
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
						--with-named-thread-libs=-lpthread \
						--with-blackhole-storage-engine \
						--with-example-storage-engine \
						--with-archive-storage-engine \
						--with-csv-storage-engine \
						--with-federated-storage-engine \
						--with-ndbcluster \
						--with-ndb-test \
						--with-ndb-docs \
						build_alias=i386-redhat-linux-gnu \
						host_alias=i386-redhat-linux-gnu \
						target_alias=i386-redhat-linux-gnu
				elif [[ $SOFT_BIGVERSION == "5.1" ]]; then
					if [[ $OS_SUFFIX != "x86_64" ]]; then
						CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC"
						CXXFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fwrapv -fPIC -felide-constructors -fno-rtti -fno-exceptions"
					fi
					if [[ $SOFT_VERSION == "5.1.51" ]]; then
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
							--with-ssl \
							--without-debug \
							--enable-shared \
							--localstatedir=/var/lib/mysql \
							--with-unix-socket-path=/var/lib/mysql/mysql.sock \
							--with-mysqld-user=mysql \
							--with-extra-charsets=all \
							--enable-community-features \
							--enable-local-infile \
							--enable-largefile \
							--enable-profiling \
							--enable-thread-safe-client \
							--disable-dependency-tracking \
							--with-named-thread-libs=-lpthread \
							--with-plugins=partition,daemon_example,ftexample,archive,blackhole,csv,example,federated,heap,ibmdb2i,innobase,innodb_plugin,myisam,myisammrg,ndbcluster \
							--with-ndb-test \
							--with-ndb-docs \
							build_alias=i386-redhat-linux-gnu \
							host_alias=i386-redhat-linux-gnu \
							target_alias=i386-redhat-linux-gnu
					elif [[ $SOFT_VERSION == "5.1.73" ]]; then
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
							--with-ssl \
							--without-debug \
							--enable-shared \
							--localstatedir=/var/lib/mysql \
							--with-unix-socket-path=/var/lib/mysql/mysql.sock \
							--with-mysqld-user=mysql \
							--with-extra-charsets=all \
							--enable-community-features \
							--enable-local-infile \
							--enable-largefile \
							--enable-profiling \
							--enable-thread-safe-client \
							--disable-dependency-tracking \
							--with-named-thread-libs=-lpthread \
							--with-plugins=partition,daemon_example,ftexample,archive,blackhole,csv,example,federated,heap,innobase,innodb_plugin,myisam,myisammrg,ndbcluster \
							--with-ndb-test \
							--with-ndb-docs \
							build_alias=i386-redhat-linux-gnu \
							host_alias=i386-redhat-linux-gnu \
							target_alias=i386-redhat-linux-gnu
					fi
				fi
			elif [[ $PrimaryVersion == "7" ]]; then
#	奇怪的问题，注释在这里实在是太奇怪了
#SEND-PR: -*- send-pr -*-
#SEND-PR: Lines starting with `SEND-PR' will be removed automatically, as
#SEND-PR: will all comments (text enclosed in `<' and `>').
<<NOEFFECT
SEND-PR:
From: jimmychou
To: maria-developers@lists.launchpad.net
Subject: [50 character or so descriptive subject here (for reference)]

>Description:
	<precise description of the problem (multiple lines)>
>How-To-Repeat:
	<code/input/activities to reproduce the problem (multiple lines)>
>Fix:
	<how to correct or work around the problem, if known (multiple lines)>

>Submitter-Id:	<submitter ID>
>Originator:	JimmyChou
>Organization:
 <organization of PR author (multiple lines)>
>MySQL support: [none | licence | email support | extended email support ]
>Synopsis:	<synopsis of the problem (one line)>
>Severity:	<[ non-critical | serious | critical ] (one line)>
>Priority:	<[ low | medium | high ] (one line)>
>Category:	mysql
>Class:		<[ sw-bug | doc-bug | change-request | support ] (one line)>
>Release:	mysql-5.5.41 (MariaDB Server)

>C compiler:    cc (GCC) 4.8.2 20140120 (Red Hat 4.8.2-16)

>C++ compiler:  c++ (GCC) 4.8.2 20140120 (Red Hat 4.8.2-16)

>Environment:
	<machine, os, target, libraries (multiple lines)>
System: Linux localhost.localdomain 3.10.0-229.1.2.el7.x86_64 #1 SMP Fri Mar 27 03:04:26 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
Architecture: x86_64

Some paths:  /usr/bin/perl /usr/bin/make /usr/bin/gmake /usr/bin/gcc /usr/bin/cc
GCC: Using built-in specs.
COLLECT_GCC=/usr/bin/gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/4.8.3/lto-wrapper
Target: x86_64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,objc,obj-c++,java,fortran,ada,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --with-isl=/builddir/build/BUILD/gcc-4.8.3-20140911/obj-x86_64-redhat-linux/isl-install --with-cloog=/builddir/build/BUILD/gcc-4.8.3-20140911/obj-x86_64-redhat-linux/cloog-install --enable-gnu-indirect-function --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
Thread model: posix
gcc version 4.8.3 20140911 (Red Hat 4.8.3-9) (GCC) 
Compilation info (call): CC='/usr/bin/cc'  CFLAGS=''  CXX='/usr/bin/c++'  CXXFLAGS=''  LDFLAGS=''  ASFLAGS=''
Compilation info (used): CC='/usr/bin/cc'  CFLAGS=''  CXX='/usr/bin/c++'  CXXFLAGS=''  LDFLAGS=''  ASFLAGS=''


Perl: This is perl 5, version 16, subversion 3 (v5.16.3) built for x86_64-linux-thread-multi
NOEFFECT
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				#sudo yum $INSTALL_OPTION install cmake.$OS_SUFFIX
				if [[ $SOFT_BIGVERSION == "5.5" ]]; then
					echo The Current $SOFT_NAME-$SOFT_VERSION like MariaDB on $OS $Version is configured as below:
					if [[ $SOFT_VERSION == "5.5.41" ]]; then
						sudo yum $INSTALL_OPTION install ncurses-devel.$OS_SUFFIX bison.$OS_SUFFIX libaio-devel.$OS_SUFFIX openssl-devel.$OS_SUFFIX
						cmake -DCMAKE_INSTALL_PREFIX=/usr \
							-DINSTALL_BINDIR=bin \
							-DSYSCONFDIR=/etc \
							-DINSTALL_INCLUDEDIR=include/mysql \
							-DINSTALL_LIBDIR=lib64/mysql \
							-DINSTALL_SBINDIR=libexec \
							-DMYSQL_DATADIR=/var/lib/mysql \
							-DINSTALL_SHAREDIR=share \
							-DINSTALL_MANDIR=share/man \
							-DINSTALL_INFODIR=share/info \
							-DWITH_READLINE=1 \
							-DWITH_SSL=yes \
							-DEXTRA_CHARSETS=all \
							-DENABLED_LOCAL_INFILE=1 \
							-DWITH_PARTITION_STORAGE_ENGINE=1 \
							-DWITH_DAEMON_EXAMPLE_STORAGE_ENGINE=1 \
							-DWITH_FTEXAMPLE_STORAGE_ENGINE=1 \
							-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
							-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
							-DWITH_CSV_STORAGE_ENGINE=1 \
							-DWITH_EXAMPLE_STORAGE_ENGINE=1 \
							-DWITH_FEDERATED_STORAGE_ENGINE=1 \
							-DWITH_HEAP_STORAGE_ENGINE=1 \
							-DWITH_INNOBASE_STORAGE_ENGINE=1 \
							-DWITH_MYISAM_STORAGE_ENGINE=1 \
							-DWITH_MYISAMMRG_STORAGE_ENGINE=1 \
							-DINSTALL_PLUGINDIR=lib64/mysql/plugin \
							-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock \
							-DWITH_EMBEDDED_SERVER=yes \
							-DWITH_EMBEDDED_SHARED_LIBRARY=1 \
							-DINSTALL_MYSQLSHAREDIR=share/mysql \
							-DINSTALL_SCRIPTDIR=bin \
							-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
							-DINSTALL_LAYOUT=RPM
					fi
				fi
			fi
			make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && rm -fr $SOFTWARE && ln -sf /mnt/hgfs/software/ $SOFTWARE
		fi
	elif [[ $i =~ ^php ]]; then
		# PHP编译
		# 可用命令 php -i | grep configure 查看，但不知为何在Ubuntu下用 apt-get install 安装的不能看到
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition -nc http://cn2.php.net/get/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX/from/this/mirror
			fi
			cd ~ && cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ~ && rm -fr $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX && cd $SOFTWARE
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			cd ~ && cp $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ~ && rm -fr $SOFTWARE && mkdir $SOFTWARE && mv ~/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFTWARE/$SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && cd $SOFTWARE
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [[ $OS == "Ubuntu" ]]; then
			echo The Official $SOFT_NAME on $OS $Version is configured as below:
		elif [[ $OS == "CentOS" ]]; then
			sudo yum $INSTALL_OPTION install bison.$OS_SUFFIX libtool.$OS_SUFFIX openssl-devel.$OS_SUFFIX bzip2-devel.$OS_SUFFIX gmp-devel.$OS_SUFFIX libc-client-devel.$OS_SUFFIX unixODBC-devel.$OS_SUFFIX postgresql-devel.$OS_SUFFIX sqlite-devel.$OS_SUFFIX aspell-devel.$OS_SUFFIX net-snmp-devel.$OS_SUFFIX
			#	configure: WARNING: bison versions supported for regeneration of the Zend/PHP parsers: 2.4 2.4.1 2.4.2 2.4.3 2.5 2.5.1 2.6 2.6.1 2.6.2 2.6.3 2.6.4 2.6.5 2.7 (found: none).
			#	安装	rpmforge源后才能安装
			sudo yum $INSTALL_OPTION install libmcrypt-devel.$OS_SUFFIX re2c.$OS_SUFFIX
			#	千万不要	sudo yum $INSTALL_OPTION install mysql-devel.$OS_SUFFIX，因为版本不一定跟系统安装的相符
			#	configure: WARNING: You will need re2c 0.13.4 or later if you want to regenerate PHP parsers.
			if [ ! -d "/etc/php.d" ]; then
				sudo mkdir /etc/php.d
			fi
			if [[ $PrimaryVersion == "5" ]]; then
				sudo yum $INSTALL_OPTION install curl-devel.$OS_SUFFIX db4-devel.$OS_SUFFIX openldap-devel.$OS_SUFFIX expat-devel.$OS_SUFFIX
<<NOEFFECT
				echo The Official $SOFT_NAME-5.1.6 on $OS $Version is configured as below:
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
				echo The Official $SOFT_NAME-5.3.3 on $OS $Version is configured as below:
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
					--without-sqlite3 \
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
					--enable-json=shared \
					--enable-zip=shared \
					--without-readline \
					--with-pspell=shared \
					--enable-phar=shared \
					--enable-sysvmsg=shared \
					--enable-sysvshm=shared \
					--enable-sysvsem=shared \
					--enable-posix=shared \
					--with-unixODBC=shared,/usr \
					--enable-fileinfo=shared \
					--enable-intl=shared \
					--with-icu-dir=/usr
NOEFFECT
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				if [[ $SOFT_VERSION == "5.1.6" ]]; then
					sudo yum $INSTALL_OPTION install flex.$OS_SUFFIX libxml2-devel.$OS_SUFFIX pcre-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX ncurses-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX
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
						--libdir=/usr/lib/php/modules \
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
						--with-curl=shared,/usr \
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
						--with-mysqli=shared,/usr/bin/mysql_config \
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
						--with-pdo-mysql=shared,/usr/bin/mysql_config \
						--with-pdo-pgsql=shared,/usr \
						--with-pdo-sqlite=shared,/usr \
						--enable-dbase=shared \
						--with-mcrypt=shared,/usr
				elif [[ $SOFT_VERSION == "5.3.3" ]]; then
					sudo yum $INSTALL_OPTION install libxml2-devel.$OS_SUFFIX pcre-devel.$OS_SUFFIX gd-devel.$OS_SUFFIX libicu-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX
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
						--without-sqlite3 \
						--with-libxml-dir=/usr \
						--enable-xml \
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
						--enable-dom=shared \
						--with-pgsql=shared \
						--enable-wddx=shared \
						--with-snmp=shared,/usr \
						--enable-soap=shared \
						--with-xsl=shared,/usr \
						--enable-xmlreader=shared \
						--enable-xmlwriter=shared \
						--with-curl=shared,/usr \
						--enable-pdo=shared \
						--with-pdo-odbc=shared,unixODBC,/usr \
						--with-pdo-mysql=shared,/usr/bin/mysql_config \
						--with-pdo-pgsql=shared,/usr \
						--with-pdo-sqlite=shared,/usr \
						--enable-json=shared \
						--enable-zip=shared \
						--without-readline \
						--with-pspell=shared \
						--enable-phar=shared \
						--enable-sysvmsg=shared \
						--enable-sysvshm=shared \
						--enable-sysvsem=shared \
						--enable-posix=shared \
						--with-unixODBC=shared,/usr \
						--enable-fileinfo=shared \
						--enable-intl=shared \
						--with-icu-dir=/usr
				elif [[ $SOFT_VERSION == "5.5.14" ]]; then
					echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
					#	不能依赖	yum	安装的库按CentOS6编译条件安装此版本PHP
					#	checking for ICU 4.0 or greater... found 3.6
				fi
			elif [[ $PrimaryVersion == "6" ]]; then
<<NOEFFECT
				echo The Official $SOFT_NAME-5.3.3 on $OS $Version is configured as below:
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
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				sudo yum $INSTALL_OPTION install libxml2-devel.$OS_SUFFIX pcre-devel.$OS_SUFFIX libcurl-devel.$OS_SUFFIX enchant-devel.$OS_SUFFIX libjpeg-turbo-devel.$OS_SUFFIX libpng-devel.$OS_SUFFIX libXpm-devel.$OS_SUFFIX freetype-devel.$OS_SUFFIX libicu-devel.$OS_SUFFIX openldap-devel.$OS_SUFFIX libedit-devel.$OS_SUFFIX recode-devel.$OS_SUFFIX libtidy-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX
				#2015年3月31日还命名为libjpeg-devel，2015年4月1日竟然更名为libjpeg-turbo-devel。莫非只是愚人节开的玩笑？
				if [[ $SOFT_VERSION == "5.3.3" ]]; then
					sudo yum $INSTALL_OPTION install libevent-devel.$OS_SUFFIX lemon.$OS_SUFFIX
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
						--libdir=/usr/lib/php/modules \
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
						--enable-dom=shared \
						--with-pgsql=shared \
						--enable-wddx=shared \
						--with-snmp=shared,/usr \
						--enable-soap=shared \
						--with-xsl=shared,/usr \
						--enable-xmlreader=shared \
						--enable-xmlwriter=shared \
						--with-curl=shared,/usr \
						--enable-pdo=shared \
						--with-pdo-odbc=shared,unixODBC,/usr \
						--with-pdo-mysql=shared,/usr/bin/mysql_config \
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
						--enable-fpm \
						--with-mcrypt=shared,/usr \
						--with-icu-dir=/usr \
						--with-enchant=shared,/usr \
						--enable-soap \
						--with-pear=/usr/bin
				elif [[ $SOFT_VERSION == "5.5.14" ]]; then
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
						--libdir=/usr/lib/php/modules \
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
						--enable-sockets \
						--enable-sysvsem \
						--enable-sysvshm \
						--enable-sysvmsg \
						--with-kerberos \
						--enable-shmop \
						--enable-calendar \
						--with-libxml-dir=/usr \
						--enable-xml \
						--enable-pcntl \
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
						--enable-dom=shared \
						--with-pgsql=shared \
						--enable-wddx=shared \
						--with-snmp=shared,/usr \
						--enable-soap=shared \
						--with-xsl=shared,/usr \
						--enable-xmlreader=shared \
						--enable-xmlwriter=shared \
						--with-curl=shared,/usr \
						--enable-pdo=shared \
						--with-pdo-odbc=shared,unixODBC,/usr \
						--with-pdo-mysql=shared,/usr/bin/mysql_config \
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
						--enable-fpm \
						--with-mcrypt=shared,/usr \
						--with-icu-dir=/usr \
						--enable-bcmath \
						--with-enchant=shared,/usr \
						--with-recode=shared,/usr
				fi
			elif [[ $PrimaryVersion == "7" ]]; then
				#sudo yum $INSTALL_OPTION install curl-devel.$OS_SUFFIX db4-devel.$OS_SUFFIX openldap-devel.$OS_SUFFIX expat-devel.$OS_SUFFIX
<<NOEFFECT
				echo The Official $SOFT_NAME-5.4.16 on $OS $Version is configured as below:
				./configure --build=x86_64-redhat-linux-gnu \
					--host=x86_64-redhat-linux-gnu \
					--program-prefix= \
					--disable-dependency-tracking \
					--prefix=/usr \
					--exec-prefix=/usr \
					--bindir=/usr/bin \
					--sbindir=/usr/sbin \
					--sysconfdir=/etc \
					--datadir=/usr/share \
					--includedir=/usr/include \
					--libdir=/usr/lib64 \
					--libexecdir=/usr/libexec \
					--localstatedir=/var \
					--sharedstatedir=/var/lib \
					--mandir=/usr/share/man \
					--infodir=/usr/share/info \
					--cache-file=../config.cache \
					--with-libdir=lib64 \
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
					--with-t1lib=/usr \
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
					--enable-sockets \
					--with-kerberos \
					--enable-shmop \
					--enable-calendar \
					--with-libxml-dir=/usr \
					--enable-xml \
					--with-system-tzdata \
					--with-mhash \
					--libdir=/usr/lib64/php \
					--enable-pcntl \
					--enable-mbstring=shared \
					--enable-mbregex \
					--with-gd=shared \
					--enable-bcmath=shared \
					--enable-dba=shared \
					--with-db4=/usr \
					--with-tcadb=/usr \
					--with-xmlrpc=shared \
					--with-ldap=shared \
					--with-ldap-sasl \
					--enable-mysqlnd=shared \
					--with-mysql=shared,mysqlnd \
					--with-mysqli=shared,mysqlnd \
					--with-mysql-sock=/var/lib/mysql/mysql.sock \
					--enable-dom=shared \
					--with-pgsql=shared \
					--enable-wddx=shared \
					--with-snmp=shared,/usr \
					--enable-soap=shared \
					--with-xsl=shared,/usr \
					--enable-xmlreader=shared \
					--enable-xmlwriter=shared \
					--with-curl=shared,/usr \
					--enable-pdo=shared \
					--with-pdo-odbc=shared,unixODBC,/usr \
					--with-pdo-mysql=shared,mysqlnd \
					--with-pdo-pgsql=shared,/usr \
					--with-pdo-sqlite=shared,/usr \
					--with-sqlite3=shared,/usr \
					--enable-json=shared \
					--enable-zip=shared \
					--with-libzip \
					--without-readline \
					--with-libedit \
					--with-pspell=shared \
					--enable-phar=shared \
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
				echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
				sudo yum $INSTALL_OPTION install libxml2-devel.$OS_SUFFIX libcurl-devel.$OS_SUFFIX enchant-devel.$OS_SUFFIX libjpeg-turbo-devel.$OS_SUFFIX libpng-devel.$OS_SUFFIX libXpm-devel.$OS_SUFFIX freetype-devel.$OS_SUFFIX t1lib-devel.$OS_SUFFIX libicu-devel.$OS_SUFFIX openldap-devel.$OS_SUFFIX libedit-devel.$OS_SUFFIX recode-devel.$OS_SUFFIX libxslt-devel.$OS_SUFFIX
				#	单独安装时，libjpeg-devel	能转化成	libjpeg-turbo-devel，但这样不能
				if [ $SOFT_VERSION == "5.4.16" ]; then
					./configure --build=x86_64-redhat-linux-gnu \
						--host=x86_64-redhat-linux-gnu \
						--program-prefix= \
						--disable-dependency-tracking \
						--prefix=/usr \
						--exec-prefix=/usr \
						--bindir=/usr/bin \
						--sbindir=/usr/sbin \
						--sysconfdir=/etc \
						--datadir=/usr/share \
						--includedir=/usr/include \
						--libdir=/usr/lib64 \
						--libexecdir=/usr/libexec \
						--localstatedir=/var \
						--sharedstatedir=/var/lib \
						--mandir=/usr/share/man \
						--infodir=/usr/share/info \
						--cache-file=../config.cache \
						--with-libdir=lib64 \
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
						--with-t1lib=/usr \
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
						--enable-sockets \
						--with-kerberos \
						--enable-shmop \
						--enable-calendar \
						--with-libxml-dir=/usr \
						--enable-xml \
						--with-system-tzdata \
						--with-mhash \
						--libdir=/usr/lib64/php/modules \
						--enable-pcntl \
						--enable-mbstring=shared \
						--enable-mbregex \
						--with-gd=shared \
						--enable-bcmath=shared \
						--enable-dba=shared \
						--with-db4=/usr \
						--with-xmlrpc=shared \
						--with-ldap=shared \
						--with-ldap-sasl \
						--enable-mysqlnd=shared \
						--with-mysql=shared,mysqlnd \
						--with-mysqli=shared,mysqlnd \
						--with-mysql-sock=/var/lib/mysql/mysql.sock \
						--enable-dom=shared \
						--with-pgsql=shared \
						--enable-wddx=shared \
						--with-snmp=shared,/usr \
						--enable-soap=shared \
						--with-xsl=shared,/usr \
						--enable-xmlreader=shared \
						--enable-xmlwriter=shared \
						--with-curl=shared,/usr \
						--enable-pdo=shared \
						--with-pdo-odbc=shared,unixODBC,/usr \
						--with-pdo-mysql=shared,mysqlnd \
						--with-pdo-pgsql=shared,/usr \
						--with-pdo-sqlite=shared,/usr \
						--with-sqlite3=shared,/usr \
						--enable-json=shared \
						--enable-zip=shared \
						--with-libzip \
						--without-readline \
						--with-libedit \
						--with-pspell=shared \
						--enable-phar=shared \
						--enable-sysvmsg=shared \
						--enable-sysvshm=shared \
						--enable-sysvsem=shared \
						--enable-posix=shared \
						--with-unixODBC=shared,/usr \
						--enable-fileinfo=shared \
						--enable-intl=shared \
						--with-icu-dir=/usr \
						--with-enchant=shared,/usr \
						--with-recode=shared,/usr \
						--enable-fpm \
						--with-fpm-user=nginx \
						--with-fpm-group=nginx
				fi
			fi
			make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip && sz config.cache && rm -fr $SOFTWARE && ln -sf /mnt/hgfs/software/ $SOFTWARE
		fi
	elif [[ $i =~ ^memcached ]]; then
		# Memcached编译
		SOFT_NAME=`echo $i | awk -F "-" '{print $1}'`
		SOFT_VERSION=`echo $i | awk -F "-" '{print $2}'`
		if [[ -z $SOFT_VERSION ]]; then
			source ./get_soft_version.sh
		fi
		cd $SOFTWARE
		if [ ! -f $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip ]; then
			if [ ! -f $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX ]; then
				wget --content-disposition http://www.memcached.org/files/$SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				tar -zvxf $SOFT_NAME-$SOFT_VERSION.$SOFT_SUFFIX
			fi
		else
			if [ ! -d $SOFT_NAME-$SOFT_VERSION ]; then
				unzip $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
			fi
		fi
		cd $SOFTWARE/$SOFT_NAME-$SOFT_VERSION
		if [[ $OS == "Ubuntu" ]]; then
			if [[ $Codename == "precise" ]]; then
				echo The Official $SOFT_NAME on $OS $Version is configured as below:
			fi
		elif [[ $OS == "CentOS" ]]; then
			sudo yum $INSTALL_OPTION install libevent-devel.$OS_SUFFIX
			echo The Current $SOFT_NAME-$SOFT_VERSION on $OS $Version is configured as below:
			if [[ $PrimaryVersion == "5" ]]; then
#				Why these cannot use?
#				./configure --build=i386-redhat-linux-gnu \
#					--host=i386-redhat-linux-gnu \
#					--target=i386-redhat-linux-gnu \
				./configure --prefix=/usr \
					--exec-prefix=/usr \
					--bindir=/usr/bin \
					--sbindir=/usr/sbin \
					--mandir=/usr/share/man \
					--includedir=/usr/include
			elif [[ $PrimaryVersion == "6" ]]; then
				./configure --prefix=/usr \
					--exec-prefix=/usr \
					--bindir=/usr/bin \
					--sbindir=/usr/sbin \
					--mandir=/usr/share/man \
					--includedir=/usr/include
			fi
			make && sudo make install && sudo /sbin/ldconfig -v && cd $SOFTWARE && zip -r $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip $SOFT_NAME-$SOFT_VERSION && sz $SOFT_NAME-$SOFT_VERSION.make_done_$OS_SUFFIX.zip
		fi
	fi
done

cd ~/下载/nginx-1.4.1
./configure --prefix=/etc/nginx\
--conf-path=/etc/nginx/nginx.conf\
--error-log-path=/var/log/nginx/error.log\
--http-client-body-temp-path=/var/lib/nginx/body\
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi\
--http-log-path=/var/log/nginx/access.log\
--http-proxy-temp-path=/var/lib/nginx/proxy\
--http-scgi-temp-path=/var/lib/nginx/scgi\
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi\
--lock-path=/var/lock/nginx.lock\
--pid-path=/var/run/nginx.pid\
--with-debug\
--with-http_addition_module\
--with-http_dav_module\
--with-http_geoip_module\
--with-http_gzip_static_module\
--with-http_image_filter_module\
--with-http_realip_module\
--with-http_stub_status_module\
--with-http_ssl_module\
--with-http_sub_module\
--with-http_xslt_module\
--with-ipv6\
--with-sha1=/usr/include/openssl\
--with-md5=/usr/include/openssl\
--with-mail\
--with-mail_ssl_module
#以下四个模块是官方在Ubuntu下的编译nginx添加的第三方模块：
#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-auth-pam\
#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-echo\
#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-upstream-fair\
#--add-module=/build/buildd/nginx-1.1.19/debian/modules/nginx-dav-ext-module

# 可用命令 nginx -V 查看

cd ~/下载/php-5.5.1
# 可用命令 php -i | grep configure 查看，但不知为何在Ubuntu下用 apt-get install 安装的不能看到


cd 
# cat /usr/bin/mysqlbug | grep configure

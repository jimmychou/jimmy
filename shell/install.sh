#!/bin/bash
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'` 
if [[ $OS == "Ubuntu" ]]; then
    #Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}'` #跟Version不同，如此还会有空格，必须按如下执行
    Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	#len=`expr length $Codename`
    Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
    echo The current Operating System is $OS and Codename is $Codename and Version is $Version
else
    OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
    Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}'`
    Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}'`
    echo The current Operating System is $OS and Codename is $Codename and Version is $Version 
fi
OS_SUFFIX=`uname -m` # uanme -p  uname -i
# 一.可以用 apt-get install 命令批量安装的软件

# 1.以下软件也都可在Ubuntu软件中心搜索找到
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "lucid" ]]; then
		apt-get install compiz-plugins openoffice.org touchfreeze ubuntuone-client ubuntuone-client-gnome ubuntuone-client-tools virtualbox-ose
		# compiz-plugins - OpenGL window and compositing manager - plugins
		# openoffice.org - office productivity suite
		# touchfreeze - a facility for disabling touchpad tap-to-click function
		# ubuntuone-client - Ubuntu One client
		# ubuntuone-client-gnome - Ubuntu One client GNOME integration
		# ubuntuone-client-tools - Ubuntu One client tools
		# virtualbox-ose - x86 virtualization solution - base binaries
	elif [[ $Codename == "precise" ]]; then
		apt-get install compiz-plugins-extra kde-config-touchpad libreoffice ubuntuone-installer virtualbox
		##compiz-plugins-extra - Collection of extra plugins from OpenCompositing for Compiz
		##?kde-config-touchpad - touchpad configuration tool (synaptiks) //其他能对应上？
		# libreoffice - office productivity suite
		##ubuntuone-installer - Ubuntu One Installer
		##virtualbox - x86 virtualization solution - base binaries（x86虚拟化解决方案 - 基本二进制程序）
	elif [[ $Codename == "raring" ]]; then
		apt-get install compiz compiz-plugins compiz-plugins-extra compiz-plugins-main compiz-plugins-main-default kde-config-touchpad libreoffice ubuntuone-client-data ubuntuone-control-panel-qt virtualbox
		# compiz - OpenGL 窗口和合成管理器
		# compiz-plugins - OpenGL window and compositing manager - plugins
		# compiz-plugins-extra - transitional dummy package.
		# compiz-plugins-main - transitional dummy package.
		# compiz-plugins-main-default - transitional dummy package.
		##?kde-config-touchpad - touchpad configuration tool (synaptiks) //其他能对应上？
		# libreoffice - office productivity suite
		# ubuntuone-client-data - Data files for Ubuntu One
		# ubuntuone-control-panel-qt - Ubuntu One Control Panel - Qt frontend
		##virtualbox - x86 virtualization solution - base binaries（x86虚拟化解决方案 - 基本二进制程序）
	fi
	apt-get install arandr camorama chmsee compizconfig-settings-manager cssed emma fcitx filezilla firefox gedit gphpedit qterm rhythmbox software-center synaptic thunderbird update-manager
	# arandr - Simple visual front end for XRandR（XRandR 的一个简单的可视化前端）
	# camorama - gnome utility to view and save images from a webcam（用于查看和保存来自摄像头的图像的 gnome 应用程序）
	# chmsee - GTK+ 环境下的 chm 阅读器
	# compizconfig-settings-manager - Compiz configuration settings manager
	# cssed - graphical CSS editor
	# emma - 可扩展的 MySQL 管理助手
	# fcitx - Flexible Input Method Framework（Fcitx 小企鹅输入法）
	# filezilla - 全功能图形界面 FTP/FTPS/SFTP 客户端
	# firefox - Safe and easy web browser from Mozilla
	# gedit - GNOME 桌面环境的官方文本编辑器
	# gphpedit - development environment for PHP/HTML/CSS（PHP/HTML/CSS 开发环境）
	# qterm - BBS client for X Window System written in Qt
	# rhythmbox - GNOME 的音乐播放器与管理器
	##software-center - Utility for browsing, installing, and removing software
	# synaptic - 图形界面的软件包管理器
	# thunderbird - Email, RSS and newsgroup client with integrated spam filter
	##update-manager - GNOME application that manages apt updates
else
	if [[ $OS == "Fedora" ]]; then
		yum install arandr.noarch camorama.$OS_SUFFIX chmsee.$OS_SUFFIX cssed.$OS_SUFFIX emma.noarch fcitx.$OS_SUFFIX filezilla.$OS_SUFFIX gphpedit.$OS_SUFFIX kcm_touchpad.$OS_SUFFIX qterm.$OS_SUFFIX synaptic.$OS_SUFFIX
		# arandr.noarch : Simple GTK+ XRandR GUI
		# camorama.$OS_SUFFIX : Gnome webcam viewer
		# chmsee.$OS_SUFFIX : HTML Help viewer for Unix/Linux
		# cssed.$OS_SUFFIX : CSS editor and validator
		# emma.noarch : Code Coverage Tool
		# fcitx.$OS_SUFFIX : Free Chinese Input Toy for X (XIM)
		# filezilla.$OS_SUFFIX : FTP, FTPS and SFTP client
		# gphpedit.$OS_SUFFIX : A PHP source editor for GNOME 2
		##?kcm_touchpad.$OS_SUFFIX : Synaptics driver based touchpads kcontrol module
		# qterm.$OS_SUFFIX : BBS client for X Window System written in Qt
		# synaptic.$OS_SUFFIX : Graphical frontend for APT package manager
	fi
	yum install compiz.$OS_SUFFIX firefox.$OS_SUFFIX gedit.$OS_SUFFIX libreoffice.$OS_SUFFIX rhythmbox.$OS_SUFFIX thunderbird.$OS_SUFFIX
	# compiz.$OS_SUFFIX : OpenGL window and compositing manager
	# firefox.$OS_SUFFIX : Mozilla Firefox Web browser
	# gedit.$OS_SUFFIX : Text editor for the GNOME desktop
	# libreoffice.$OS_SUFFIX : Free Software Productivity Suite
	# rhythmbox.$OS_SUFFIX : Music Management Application
	# thunderbird.$OS_SUFFIX : Mozilla Thunderbird mail/newsgroup client
fi


# 2.以下软件都能在Ubuntu软件中心搜索找到，但是没有特定的icon
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "lucid" ]]; then
		apt-get install chkconfig git-core phpunit-doc smarty
		# chkconfig - system tool to enable or disable system services
		# git-core - fast, scalable, distributed revision control system
		# phpunit-doc - Manual for phpunit
		# smarty - Template engine for PHP
	elif [[ $Codename == "precise" ]]; then
		apt-get install chkconfig git php5-fpm php-doc smarty
		# chkconfig - system tool to enable or disable system services //不知道10.04优美与
		# git - fast, scalable, distributed revision control system
		# php5-fpm - server-side, HTML-embedded scripting language (FPM-CGI binary)
		# php-doc - Documentation for PHP5
		# smarty - Template engine for PHP
	elif [[ $Codename == "raring" ]]; then
		apt-get install git  php5-fpm php-doc smarty3
		# git - fast, scalable, distributed revision control system
		# php5-fpm - server-side, HTML-embedded scripting language (FPM-CGI binary)
		# php-doc - Documentation for PHP5
		# smarty3 - Template engine for PHP
	fi
	apt-get install apache2 cakephp cmake exif gcc g++ keepalived libapache2-mod-php5 logrotate lrzsz lsb memcached mysql-client mysql-server nginx nmon p7zip-full php5 php5-cgi php5-cli php5-common php5-curl php5-dev php5-gd php5-imagick php5-memcached php5-mysql phpmyadmin php-apc php-pear phpunit puppet readpst redis-server sphinxsearch sshpass subversion sysstat unrar vim vim-puppet zend-framework
	# apache2 - Apache HTTP Server metapackage
	##cakephp - MVC rapid application development framework for PHP
	# cmake - cross-platform, open-source make system
	# exif - command-line utility to show EXIF information in JPEG files
	# gcc - GNU C compiler
	# g++ - GNU C++ compiler
	# keepalived - Failover and monitoring daemon for LVS clusters
	##libapache2-mod-php5 - server-side, HTML-embedded scripting language (Apache 2 module)
	# logrotate - 日志 ratation(FIXME) 工具
	# lrzsz - Tools for zmodem/xmodem/ymodem file transfer
	# lsb - Linux Standard Base 4.0 support package
	# memcached - A high-performance memory object caching system
	# mysql-client - MySQL database client (metapackage depending on the latest version)
	# mysql-server - MySQL database server (metapackage depending on the latest version)
	# nginx - small, but very powerful and efficient web server and mail proxy
	# nmon - performance monitoring tool for Linux
	# p7zip-full - 7z and 7za file archivers with high compression ratio
	# php5 - server-side, HTML-embedded scripting language (metapackage)
	# php5-cgi - server-side, HTML-embedded scripting language (CGI binary)
	# php5-cli - command-line interpreter for the php5 scripting language
	# php5-common - Common files for packages built from the php5 source
	##php5-curl - CURL module for php5
	# php5-dev - Files for PHP5 module development
	# php5-gd - GD module for php5
	# php5-imagick - ImageMagick module for php5
	# php5-memcached - memcached extension module for PHP5, uses libmemcached
	# php5-mysql - MySQL module for php5
	# phpmyadmin - MySQL web administration tool
	##php-apc - APC (Alternative PHP Cache) module for PHP 5
	# php-pear - PEAR - PHP Extension and Application Repository
	# phpunit - Unit testing suite for PHP5
	# puppet - Centralized configuration management - agent startup and compatibility scripts
	# readpst - Utilities to convert Outlook .pst files to other formats
	# redis-server - Persistent key-value database with network interface
	# sphinxsearch - Fast standalone full-text SQL search engine
	# sshpass - Non-interactive ssh password authentication
	# subversion - Advanced version control system
	# sysstat - system performance tools for Linux
	# unrar - Unarchiver for .rar files (non-free version)
	# vim - Vi 增强版 - 增强的 vi 编辑器
	##vim-puppet - syntax highlighting for puppet manifests in vim
	# zend-framework - a simple, straightforward, open-source software framework for PHP 5
else
	if [[ $OS == "Fedora" ]]; then
		yum install exif.$OS_SUFFIX php-pecl-http.$OS_SUFFIX community-mysql.$OS_SUFFIX community-mysql-bench.$OS_SUFFIX community-mysql-server.$OS_SUFFIX nginx.$OS_SUFFIX nmon.$OS_SUFFIX p7zip.$OS_SUFFIX lighttpd-fastcgi.$OS_SUFFIX php-pear-Net-Curl.noarch php-pecl-imagick.$OS_SUFFIX php-pecl-memcached.$OS_SUFFIX php-mysqlnd.$OS_SUFFIX phpMyAdmin.noarch php-pear-PhpDocumentor.noarch puppet.noarch redis.$OS_SUFFIX phpMemcachedAdmin.noarch sphinx-php.$OS_SUFFIX php-Smarty.noarch php-Smarty2.noarch sphinx.$OS_SUFFIX sshpass.$OS_SUFFIX unar.$OS_SUFFIX php-ZendFramework.noarch php-ZendFramework-full.noarch
		# exif.$OS_SUFFIX : Utility to show EXIF information hidden in JPEG files
		# php-pecl-http.$OS_SUFFIX : Extended HTTP support
		# community-mysql.$OS_SUFFIX : MySQL client programs and shared libraries
		##community-mysql-bench.$OS_SUFFIX : MySQL benchmark scripts and data
		# community-mysql-server.$OS_SUFFIX : The MySQL server and related files
		# nginx.$OS_SUFFIX : A high performance web server and reverse proxy server
		# nmon.$OS_SUFFIX : Nigel's performance Monitor for Linux
		# p7zip.$OS_SUFFIX : Very high compression ratio file archiver
		#?#lighttpd-fastcgi.$OS_SUFFIX : FastCGI module and spawning helper for lighttpd and PHP
		#?#php-pear-Net-Curl.noarch : OO interface to PHP's cURL extension
		#?#php-pecl-imagick.$OS_SUFFIX : Provides a wrapper to the ImageMagick library
		#?#php-pecl-memcached.$OS_SUFFIX : Extension to work with the Memcached caching daemon
		#?php-mysqlnd.$OS_SUFFIX : A module for PHP applications that use MySQL databases
		#?#phpMyAdmin.noarch : Handle the administration of MySQL over the World Wide Web
		#?#php-pear-PhpDocumentor.noarch : The complete documentation solution for PHP
		# puppet.noarch : A network tool for managing many disparate systems
		# redis.$OS_SUFFIX : A persistent key-value database
		##phpMemcachedAdmin.noarch : Graphic stand-alone administration for memcached to monitor and debug purpose
		##sphinx-php.$OS_SUFFIX : PHP API for Sphinx
		# php-Smarty.noarch : Template/Presentation Framework for PHP
		# php-Smarty2.noarch : Template/Presentation Framework for PHP
		# sphinx.$OS_SUFFIX : Free open-source SQL full-text search engine
		# sshpass.$OS_SUFFIX : Non-interactive SSH authentication utility
		# unar.$OS_SUFFIX : Multi-format extractor
		# php-ZendFramework.noarch : Leading open-source PHP framework
		# php-ZendFramework-full.noarch : Meta package to install full Zend Framework
	else
		yum install mysql.$OS_SUFFIX mysql-bench.$OS_SUFFIX mysql-server.$OS_SUFFIX php-mysql.$OS_SUFFIX
		# mysql.$OS_SUFFIX : MySQL client programs and shared libraries
		##mysql-bench.$OS_SUFFIX : MySQL benchmark scripts and data
		# mysql-server.$OS_SUFFIX : The MySQL server and related files
		#?php-mysql.$OS_SUFFIX : A module for PHP applications that use MySQL databases   // Fedora不存在？
	fi
	yum install httpd.$OS_SUFFIX chkconfig.$OS_SUFFIX cmake.$OS_SUFFIX gcc.$OS_SUFFIX gcc-c++.$OS_SUFFIX git.$OS_SUFFIX keepalived.$OS_SUFFIX logrotate.$OS_SUFFIX lrzsz.$OS_SUFFIX redhat-lsb.$OS_SUFFIX memcached.$OS_SUFFIX php.$OS_SUFFIX php-cli.$OS_SUFFIX php-common.$OS_SUFFIX php-devel.$OS_SUFFIX php-fpm.$OS_SUFFIX php-gd.$OS_SUFFIX php-mbstring.$OS_SUFFIX php-pecl-apc.$OS_SUFFIX php-pear.noarch libpst.$OS_SUFFIX subversion.$OS_SUFFIX sysstat.$OS_SUFFIX vim-enhanced.$OS_SUFFIX yum-plugin-fastestmirror.noarch
	# httpd.$OS_SUFFIX : Apache HTTP Serve
	# chkconfig.$OS_SUFFIX : A system tool for maintaining the /etc/rc*.d hierarchy
	# cmake.$OS_SUFFIX : Cross-platform make system
	# gcc.$OS_SUFFIX : Various compilers (C, C++, Objective-C, Java, ...)
	# gcc-c++.$OS_SUFFIX : C++ support for GCC
	# git.$OS_SUFFIX : Fast Version Control System
	# keepalived.$OS_SUFFIX : High Availability monitor built upon LVS, VRRP and service pollers
	# logrotate.$OS_SUFFIX : Rotates, compresses, removes and mails system log files
	# lrzsz.$OS_SUFFIX : The lrz and lsz modem communications programs
	# redhat-lsb.$OS_SUFFIX : LSB base libraries support for CentOS
	# memcached.$OS_SUFFIX : High Performance, Distributed Memory Object Cache
	# php.$OS_SUFFIX : PHP scripting language for creating dynamic web sites
	# php-cli.$OS_SUFFIX : Command-line interface for PHP
	# php-common.$OS_SUFFIX : Common files for PHP
	# php-devel.$OS_SUFFIX : Files needed for building PHP extensions
	# php-fpm.$OS_SUFFIX : PHP FastCGI Process Manager
	# php-gd.$OS_SUFFIX : A module for PHP applications for using the gd graphics library
	##php-mbstring.$OS_SUFFIX : A module for PHP applications which need multi-byte string handling
	##php-pecl-apc.$OS_SUFFIX : APC caches and optimizes PHP intermediate code
	# php-pear.noarch : PHP Extension and Application Repository framework
	# libpst.$OS_SUFFIX : Utilities to convert Outlook .pst files to other formats
	# subversion.$OS_SUFFIX : A Modern Concurrent Version Control System
	# sysstat.$OS_SUFFIX : Collection of performance monitoring tools for Linux
	# vim-enhanced.$OS_SUFFIX : A version of the VIM editor which includes recent enhancements
	##yum-plugin-fastestmirror.noarch : Yum plugin which chooses fastest repository from a mirrorlist
fi

# 3.以下也都可以在第三方官方网站下载安装
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "lucid" ]]; then
		echo Nothing to do
	elif [[ $Codename == "precise" ]]; then
		apt-get install google-chrome-stable 
		# google-chrome-stable - The web browser from Google  #需要手动加入第三方源
	elif [[ $Codename == "raring" ]]; then
		apt-get install google-chrome-stable 
		# google-chrome-stable - The web browser from Google  #需要手动加入第三方源
	fi
	apt-get install adobe-flashplugin opera 
	##adobe-flashplugin - Adobe Flash Player plugin version 11 在“长城宽带”的网络环境下，如果把它放在必装软件的头一条，竟然会影响之后的软件安装
	##opera - Fast and secure web browser and Internet suite
	#/opera-next - Fast and secure web browser and Internet suite //貌似这个版本比上面的版本还要旧，这是为何？
else
	if [[ $OS == "Fedora" ]]; then
		yum install gnash-plugin.$OS_SUFFIX google-chrome-stable
		#?gnash-plugin.$OS_SUFFIX : Web-client flash movie player plugin  //adobe-flashplugin是这个？
		# google-chrome-stable.386 : Google Chrome  #需要手动加入第三方源，只有386，没有686
	fi
	yum install flash-plugin.$OS_SUFFIX opera
	# flash-plugin.$OS_SUFFIX : Adobe Flash Player 11.2
	# opera.i386 : Fast and secure web browser and Internet suite
fi

# 二.只能在Ubuntu软件中心搜索安装的软件

# 三.只能在第三方官方网站下载安装的软件
# 1.Xmind
# （兼容MindManager，有免费版） http://www.xmind.net/ 下载三合一的版本后解压，XMind_Linux目录和Commons目录放在一起，在菜单搜索xmind将图标放在桌面，然后再把XMind.ini里的相对路径改为绝对路径即可。
# 2.CodeIgniter
# 3.ZendStudio

# 四.以下软件为可选
# 1.以下软件也都可在Ubuntu软件中心搜索找到
if [[ $OS == "Ubuntu" ]]; then
	if [ $Codename == "lucid" ]; then
		echo Nothing to do
	elif [[ $Codename == "precise" ]]; then
		apt-get install activity-log-manager
		##activity-log-manager - blacklist configuration user interface for Zeitgeist //跟“隐私”功能一样，但居然是两个软件？！
	elif [[ $Codename == "raring" ]]; then
		apt-get install activity-log-manager
		##activity-log-manager - blacklist configuration user interface for Zeitgeist //跟“隐私”功能一样，但居然是两个软件？！
	fi
	apt-get install amarok bluefish chromium-browser eclipse kdesvn pidgin stardict wireshark
	# amarok - easy to use media player based on the KDE Platform
	# bluefish - advanced Gtk+ HTML editor
	##chromium-browser - Chromium 浏览器
	##eclipse - Extensible Tool Platform and Java IDE
	##kdesvn - Subversion client with tight KDE integration
	# pidgin - graphical multi-protocol instant messaging client for X
	# stardict - 多语言词典
	# wireshark - network traffic analyzer - GTK+ version
else
	if [[ $OS == "Fedora" ]]; then
		yum install amarok.$OS_SUFFIX bluefish.$OS_SUFFIX stardict.$OS_SUFFIX
		# amarok.$OS_SUFFIX : Media player
		# bluefish.$OS_SUFFIX : GTK2 web development application for experienced users
		# stardict.$OS_SUFFIX : A powerful dictionary platform written in GTK+2
	fi
	yum install pidgin.$OS_SUFFIX wireshark.$OS_SUFFIX
	# pidgin.$OS_SUFFIX : A Gtk+ based multiprotocol instant messaging client
	# wireshark.$OS_SUFFIX : Network traffic analyzer
fi

# 2.以下软件都能在Ubuntu软件中心搜索找到，但是没有特定的icon
if [[ $OS == "Ubuntu" ]]; then
	apt-get install libpcre3-dev libzlcore-dev openssh-client openssh-server openvpn puppetmaster python-mutagen screen sysbench tmux tree
	# libpcre3-dev - Perl 5 Compatible Regular Expression Library - development files，为nginx源码编译需要的PCRE准备
	# libzlcore-dev - ZLibrary cross-platform development library (development files)
	# openssh-client - secure shell (SSH) client, for secure access to remote machines
	# openssh-server - secure shell (SSH) server, for secure access from remote machines
	# openvpn - virtual private network daemon
	# puppetmaster - Centralized configuration management - master startup and compatibility scripts
	##python-mutagen - audio metadata editing library，Amarok中文乱码命令mid3conv需要的软件包
	# screen - terminal multiplexor with VT100/ANSI terminal emulation
	# sysbench - Cross-platform and multi-threaded benchmark tool
	# tmux - terminal multiplexer
	# tree - displays directory tree, in color
else
	if [[ $OS == "Fedora" ]]; then
		yum install openvpn.$OS_SUFFIX peervpn.$OS_SUFFIX puppet-server.noarch sysbench.$OS_SUFFIX tmux.$OS_SUFFIX
		# openvpn.$OS_SUFFIX : A full-featured SSL VPN solution
		##peervpn.$OS_SUFFIX : A VPN software using full mesh network topology
		# puppet-server.noarch : Server for the puppet system management tool
		# sysbench.$OS_SUFFIX : System performance benchmark
		# tmux.$OS_SUFFIX : A terminal multiplexer
	fi
	yum install pcre-devel.$OS_SUFFIX zlib-devel.$OS_SUFFIX openssh.$OS_SUFFIX openssh-server.$OS_SUFFIX screen.$OS_SUFFIX tree.$OS_SUFFIX
	# pcre-devel.$OS_SUFFIX : Development files for pcre，为nginx源码编译需要的PCRE准备
	# zlib-devel.$OS_SUFFIX : Header files and libraries for Zlib development，同样是为nginx源码编译需要的PCRE准备
	# openssh.$OS_SUFFIX : An open source implementation of SSH protocol versions 1 and 2
	# openssh-server.$OS_SUFFIX : An open source SSH server daemon
	# screen.$OS_SUFFIX : A screen manager that supports multiple logins on one terminal
	# tree.$OS_SUFFIX : File system tree viewer
fi

# 3.以下桌面安装要慎重选择，否则卸载就比较麻烦了
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "lucid" ]]; then
		apt-get install edubuntu-desktop-kde
		# edubuntu-desktop-kde - educational desktop for Kubuntu (unsupported)
	elif [[ $Codename == "precise" ]]; then
		apt-get install edubuntu-desktop-kde
		# edubuntu-desktop-kde - educational desktop for Kubuntu (unsupported)
	elif [[ $Codename == "raring" ]]; then
		apt-get install ubuntukylin-default-settings ubuntukylin-theme ubuntu-gnome-desktop
		# ubuntukylin-default-settings - Default settings for the UbuntuKylin desktop
		# ubuntukylin-theme - UbuntuKylin theme
		# ubuntu-gnome-desktop - The Ubuntu GNOME metapackage
	fi
	apt-get install edubuntu-desktop gnome-desktop-environment kde-standard kde-full kubuntu-desktop lubuntu-desktop xfce4 ubuntu-desktop ubuntustudio-desktop xubuntu-desktop
	# edubuntu-desktop - educational desktop for Ubuntu
	# gnome-desktop-environment - The GNOME Desktop Environment - transitional package
	# kde-standard - KDE Plasma Desktop and standard set of applications
	# kde-full - complete KDE Software Compilation for end users
	# kubuntu-desktop - Kubuntu Plasma Desktop/Netbook system
	# lubuntu-desktop - Lubuntu Desktop environment
	# xfce4 - Meta-package for the Xfce Lightweight Desktop Environment
	# ubuntu-desktop - The Ubuntu desktop system
	# ubuntustudio-desktop - Ubuntu Studio Desktop Package
	# xubuntu-desktop - Xubuntu desktop system
else
	if [[ $OS == "Fedora" ]]; then
		yum groups install "GNOME Desktop" "KDE Desktop" "Xfce Desktop"
		# 桌面环境安装过后再安装就会提示找不着相关环境
		yum groups install "Development tools"
	else
		yum groupinstall "KDE Desktop"
		yum groupinstall "Development tools" "Eclipse" "Emacs" "Input Methods" "Java Platform"
	fi
fi
#注意事项：
#更新源列表要小心，不要更新成12.11的了，一定要选对版本，点击右边的目录链接。而且更新时会提示第三方源要小心……后来我就还原了。用新立得安装，一打开即提示有软件依赖关系已经破坏，原来是xmind

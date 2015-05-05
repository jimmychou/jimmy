#!/bin/bash
INSTALL_OPTION=''
LSB_EXIST=''
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'`
	#   此语句仅仅对Debian系的Ubuntu有效
OS_SUFFIX=`uname -m`
if [[ $OS == "Ubuntu" ]]; then
	for i in $*; do
		if [[ $i =~ ^- ]]; then
			#	=~	右边不用引号的话是正则表达式，以	-	开头，以避免	build.sh	脚本传入版本号被当成安装参数。如果用了引号则表示子串包含判断。
			INSTALL_OPTION=${INSTALL_OPTION}" "${i}
		fi
	done
	if [[ -z $INSTALL_OPTION ]]; then
		INSTALL_OPTION=" -d "
	fi
	LSB_EXIST=`dpkg --get-selections | grep lsb`
	if [[ -z $LSB_EXIST ]]; then
		sudo apt-get $INSTALL_OPTION install lsb
	fi
	if [[ $SCRIPT_ACTION =~ 'INSTALL' ]]; then
		sudo apt-get $INSTALL_OPTION install g++
	fi
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	PrimaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $1}'`
	SecondaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $2}'`
	ThirdaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $3}'`
	declare -l OS_DIR=$OS
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion and ThirdaryVersion is $ThirdaryVersion
else
	for i in $*; do
		if [[ $i =~ ^- ]]; then
			#	=~	右边不用引号的话是正则表达式，以	-	开头，以避免	build.sh	脚本传入版本号被当成安装参数。如果用了引号则表示子串包含判断。
			INSTALL_OPTION=${INSTALL_OPTION}" "${i}
		fi
	done
	if [[ -z $INSTALL_OPTION ]]; then
		INSTALL_OPTION=" -y "
	fi
	if [[ $SCRIPT_ACTION =~ 'INSTALL' ]]; then
		#	包含即可，无需用	INSTALL	开头
		sudo yum $INSTALL_OPTION install gcc-c++
	fi
	LSB_EXIST=`rpm -qa | grep 'redhat-lsb' `
	if [[ -z $LSB_EXIST ]]; then
		sudo yum $INSTALL_OPTION install redhat-lsb
	fi
	RPM_FORGE_EXIST=`rpm -qa | grep 'rpmforge-release'`
	OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}'`
	if [[ $OS == "CentOS" ]]; then
		PrimaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $1}'`
		SecondaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $2}'`
		echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion
		#	将系统目录转换为小写
		if [[ $PrimaryVersion == "5" ]]; then
			OS_DIR=`echo $OS | tr '[A-Z]' '[a-z]'`
				#	CentOS5	的	bash	版本为3，declare	命令不支持大小写转换，需要	bash4	支持
		else
			declare -l OS_DIR=$OS
		fi
		if [[ -z $RPM_FORGE_EXIST ]]; then
			if [[ $OS_SUFFIX != "x86_64" ]]; then
				if [[ $PrimaryVersion == "5" ]]; then
					OS_SUFFIX="i386"
				fi
			fi
			sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el$PrimaryVersion.rf.$OS_SUFFIX.rpm
		fi
		if [[ $SCRIPT_ACTION =~ 'INSTALL' ]]; then
			#	包含即可，无需用	INSTALL	开头
			if [[ $PrimaryVersion == "5" ]]; then
				sudo yum $INSTALL_OPTION install yum-fastestmirror.noarch
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo yum $INSTALL_OPTION install yum-plugin-fastestmirror.noarch
			fi
		fi
	else
		#	为	Fedora	等类	RedHat Linux	系统预留
		echo The current Operating System is $OS and Codename is $Codename and Version is $Version
	fi
fi

#!/bin/bash
INSTALL_OPTION=''
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'`  #   此语句仅仅对Debian系的Ubuntu有效
if [[ $OS == "Ubuntu" ]]; then
	for i in $*; do
		if [[ $i =~ '-' ]]; then
			INSTALL_OPTION=${INSTALL_OPTION}" "${i}
		fi
	done
	if [[ -z $INSTALL_OPTION ]]; then
		INSTALL_OPTION=" -d "
	fi
	sudo apt-get $INSTALL_OPTION install lsb g++
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	PrimaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $1}'`
	SecondaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $2}'`
	ThirdaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $3}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion and ThirdaryVersion is $ThirdaryVersion
else
	for i in $*; do
		if [[ $i =~ '-' ]]; then
			INSTALL_OPTION=${INSTALL_OPTION}" "${i}
		fi
	done
	if [[ -z $INSTALL_OPTION ]]; then
		INSTALL_OPTION=" -y "
	fi
	sudo yum $INSTALL_OPTION install redhat-lsb gcc-c++
	RPM_FORGE_EXIST=`rpm -qa | grep 'rpmforge-release' `
	OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}'`
	if [[ $OS == "CentOS" ]]; then
		PrimaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $1}'`
		SecondaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $2}'`
		echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion
		if [[ -z $RPM_FORGE_EXIST ]]; then
			if [[ $PrimaryVersion == "5" ]]; then
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.i386.rpm
			elif [[ $PrimaryVersion == "6" ]]; then
				sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.i686.rpm
			fi
		fi
		if [[ $PrimaryVersion == "5" ]]; then
			sudo yum $INSTALL_OPTION install yum-fastestmirror.noarch
		elif [[ $PrimaryVersion == "6" ]]; then
			sudo yum $INSTALL_OPTION install yum-plugin-fastestmirror.noarch
		fi
	else
		#	为	Fedora	等类	RedHat Linux	系统预留
		echo The current Operating System is $OS and Codename is $Codename and Version is $Version
	fi
fi
OS_SUFFIX=`uname -m`
OS_SUFFIX_SPECIAL=$OS_SUFFIX
if [[ $OS_SUFFIX == "i686" ]]; then
	OS_SUFFIX_SPECIAL=i386
#	if [[ $Version == "5.9" ]]; then	#	应该是5而不是每个细小的版本	
	if [[ $PrimaryVersion == "5" ]]; then
		OS_SUFFIX="i386"
	fi
fi

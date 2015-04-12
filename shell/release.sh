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
	sudo yum install -y redhat-lsb gcc-c++ yum-plugin-fastestmirror.noarch
	RPM_FORGE_EXIST=`rpm -qa | grep 'rpmforge-release' `
	if [[ -z $RPM_FORGE_EXIST ]]; then
		sudo rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.i686.rpm
	fi
	OS=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $1}'`
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}'`
	if [[ $OS == "CentOS" ]]; then
		PrimaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $1}'`
		SecondaryVersion=`lsb_release -a | grep Release | awk -F ":" '{print $2}' | awk '{print $1}' | awk -F "." '{print $2}'`
		echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion
	else
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

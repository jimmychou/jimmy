#!/bin/bash
OS=`uname -v | awk '{print $1}' | awk -F "-" '{print $2}'`  #   此语句仅仅对Debian系的Ubuntu有效
if [[ $OS == "Ubuntu" ]]; then
	sudo apt-get install -y lsb g++
	Codename=`lsb_release -a | grep Codename | awk -F ":" '{print $2}' | awk '{print $1}'`
	Version=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}'`
	PrimaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $1}'`
	SecondaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $2}'`
	ThirdaryVersion=`lsb_release -a | grep Description | awk -F ":" '{print $2}' | awk '{print $2}' | awk -F "." '{print $3}'`
	echo The current Operating System is $OS and Codename is $Codename and Version is $Version and PrimaryVersion is $PrimaryVersion and SecondaryVersion is $SecondaryVersion and ThirdaryVersion is $ThirdaryVersion
else
	sudo yum install -y redhat-lsb gcc-c++
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

#!/bin/bash
#	根据系统情况判断软件版本
if [[ $OS == "Ubuntu" ]]; then
	if [[ $Codename == "hardy" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		fi
	elif [[ $Codename == "lucid" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		elif [[ $i == "httpd" ]]; then
			SOFT_VERSION=2.2.14
		elif [[ $i == "mysql" ]]; then
			SOFT_VERSION=5.1.41
		elif [[ $i == "php" ]]; then
			SOFT_VERSION=5.3.2
		fi
	elif [[ $Codename == "precise" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		elif [[ $i == "httpd" ]]; then
			SOFT_VERSION=2.2.22
		elif [[ $i == "mysql" ]]; then
			SOFT_VERSION=5.5.22
		elif [[ $i == "php" ]]; then
			SOFT_VERSION=5.3.10
		fi
	elif [[ $Codename == "quantal" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		elif [[ $i == "httpd" ]]; then
			SOFT_VERSION=2.2.22
		elif [[ $i == "mysql" ]]; then
			SOFT_VERSION=5.5.27
		elif [[ $i == "php" ]]; then
			SOFT_VERSION=5.4.6
		fi
	elif [[ $Codename == "raring" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		elif [[ $i == "httpd" ]]; then
			SOFT_VERSION=2.2.22
		elif [[ $i == "mysql" ]]; then
			SOFT_VERSION=5.5.29
		elif [[ $i == "php" ]]; then
			SOFT_VERSION=5.4.9
		fi
	elif [[ $Codename == "trusty" ]]; then
		if [[ $i == "nginx" ]]; then
			SOFT_VERSION=1.0.14
		elif [[ $i == "httpd" ]]; then
			SOFT_VERSION=2.4.7
		elif [[ $i == "mysql" ]]; then
			SOFT_VERSION=5.5.35
		elif [[ $i == "php" ]]; then
			SOFT_VERSION=5.5.9
		fi
	fi
else
	if [[ $OS == "Fedora" ]]; then
		if [[ $Version == "16" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.2.21
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.5.14
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.3.8
			fi
		elif [[ $Version == "17" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.2.22
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.5.23
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.4.1
			fi
		elif [[ $Version == "18" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.4.3
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.5.28
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.4.9
			fi
		elif [[ $Version == "19" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.4.4
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.5.31
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.5.0
			fi
		fi
	elif [[ $OS == "CentOS" ]]; then
		if [[ $PrimaryVersion == "5" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.2.3
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.0.95
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.1.6
			fi
		elif [[ $PrimaryVersion == "6" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.2.15
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.1.73
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.3.3
			fi
		elif [[ $PrimaryVersion == "7" ]]; then
			if [[ $i == "nginx" ]]; then
				SOFT_VERSION=1.0.14
			elif [[ $i == "httpd" ]]; then
				SOFT_VERSION=2.4.6
			elif [[ $i == "mysql" ]]; then
				SOFT_VERSION=5.5.41
			elif [[ $i == "php" ]]; then
				SOFT_VERSION=5.4.16
			fi
		fi
	fi
fi

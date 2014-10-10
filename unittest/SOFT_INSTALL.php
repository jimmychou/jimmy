<?php
#soft.GoPostInstallLog
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$time = time();
//$query = "{'SOFT_INSTALL_STATE':'1','ID':'1762325','PKGNAME':'com.baidu.BaiduMap','VR':'5','VCODE':'559','MD5':'515f8174035220b54592520137d85541','KEY':'SOFT_INSTALL','INSTALL_FAILED_CODE':'0','AUTO_INSTALL_FAILED_DESC':'0'}";
$query = "{'SOFT_INSTALL_STATE':'1','ID':'1707755','PKGNAME':'com.baidu.BaiduMap','VR':'5','VCODE':'550','MD5':'e0abb923777ec404037341c644c4d1ca','KEY':'SOFT_INSTALL','INSTALL_FAILED_CODE':'0','AUTO_INSTALL_FAILED_DESC':'0'}";
//  MD5值从 sj_soft_file    中获取
request($query);

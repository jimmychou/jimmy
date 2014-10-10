<?php
#soft.GoGetHistorySoft
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$time = time();
$query = "{'KEY':'GET_HISTORY_VERSIONS','ID':'1707755','VR':'13','LIST_INDEX_START':'0','LIST_INDEX_SIZE':'10'}";
//,'SOFT_INSTALL_STATE':'1','ID':'1707755','PKGNAME':'com.baidu.BaiduMap','VR':'5','VCODE':'550','MD5':'e0abb923777ec404037341c644c4d1ca','KEY':'SOFT_INSTALL','INSTALL_FAILED_CODE':'0','AUTO_INSTALL_FAILED_DESC':'0'}";
//  MD5值从 sj_soft_file    中获取
request($query);

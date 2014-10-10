<?php
#soft.GoGetSoftUpdatePage
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$time = time();
$query = "{'KEY':'SOFT_UPDATE_PAGE','REQUIRE':'1','VR':'6','ATC_TMS':'".time()."','DATA':[['com.baidu.BaiduMap','550','1','8000','80']],'REQ_GAME_DATA':'1'}";
//,'SOFT_INSTALL_STATE':'1','ID':'1707755','PKGNAME':'com.baidu.BaiduMap','VR':'5','VCODE':'550','MD5':'e0abb923777ec404037341c644c4d1ca','KEY':'SOFT_INSTALL','INSTALL_FAILED_CODE':'0','AUTO_INSTALL_FAILED_DESC':'0'}";
//  MD5值从 sj_soft_file    中获取
request($query);

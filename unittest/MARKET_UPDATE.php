<?php
#market.GoGetMarketUpdate
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
/*
$query = '{"SIGN":"218151532,-1185945285","VR":3,"APK_MD5":"55b9b3c48de01f93c38d6a46383b3d5c","SUPPLIERS":"d0f6f1cedb47344c5a6bff4c7824a8faadc20d20","VERSION_CODE":5400,"REQ_ATC_TMS":1,"SYNC":2,"FIRMWARE":"345678","PATH":"","KEY":"MARKET_UPDATE","ALLOW_DELTA":1,"NATIVE_LOADED":1,"TYPE":"app"}';
request($query);
*/

//  通用渠道所有版本测试
/*
$version_codes = array(5410,5320,5310,5300,5210,5200,5101,5100,5001,5000,4430,4420,4410,4400,4310,4200,4100,3902,3901,3500,3400,3300,3201,3200,3003,3002,3000,2992,2001,2000,1310,1300,1210,1200,1100,1001,96,94,93,92,91,90,82,81,80,70,61,60,50,44,43,42,41,40,39,38,37,36,35,2,1,0);
foreach($version_codes as $version_code){
    $query = '{"SIGN":"218151532,-1185945285","VR":3,"APK_MD5":"55b9b3c48de01f93c38d6a46383b3d5c","SUPPLIERS":"d0f6f1cedb47344c5a6bff4c7824a8faadc20d20","VERSION_CODE":'.$version_code.',"REQ_ATC_TMS":1,"SYNC":2,"FIRMWARE":"345678","PATH":"","KEY":"MARKET_UPDATE","ALLOW_DELTA":1,"NATIVE_LOADED":1,"TYPE":"app"}';
    request($query);
}
*/

//  推动力3渠道测试
/*
$version_code = 5300;
$query = '{"SIGN":"218151532,-1185945285","VR":3,"APK_MD5":"55b9b3c48de01f93c38d6a46383b3d5c","SUPPLIERS":"f15231992b516c6292607d5d66af4d5d03a2c389","VERSION_CODE":'.$version_code.',"REQ_ATC_TMS":1,"SYNC":2,"FIRMWARE":"345678","PATH":"","KEY":"MARKET_UPDATE","ALLOW_DELTA":1,"NATIVE_LOADED":1,"TYPE":"app"}';
request($query);
*/

//  5.4.1
$query = '{"SIGN":"218151532,-1185945285","VR":3,"APK_MD5":"7909dc4aeaba5e5877695ff7f8a530a6","SUPPLIERS":"d0f6f1cedb47344c5a6bff4c7824a8faadc20d20","VERSION_CODE":5410,"REQ_ATC_TMS":1,"SYNC":2,"FIRMWARE":"345678","PATH":"","KEY":"MARKET_UPDATE","ALLOW_DELTA":1,"NATIVE_LOADED":1,"TYPE":"app"}';
request($query);

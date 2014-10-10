<?php
#soft.GoGetSoftDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$VR = 3;
$VR = 8;
//  百度地图
//$query = "{'ID':'1762325','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  刀塔传奇
//$query = "{'ID':'1707517','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  藏地神山，电子书
$query = "{'ID':'593114','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  捕鱼达人OL
//$query = "{'ID':'1769025','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  么么哒
//$query = "{'ID':'1824623','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  糖医生
//$query = "{'ID':'1814410','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
request($query);

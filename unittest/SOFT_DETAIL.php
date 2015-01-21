<?php
#soft.GoGetSoftDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$VR = 3;
$VR = 8;
$VR = 10;
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

//  腾讯微视
$query = "{'ID':'1767457','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";

//  189邮箱
$query = "{'ID':'1706581','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";

//  中国天气预报
$query = "{'ID':'199220','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";

//  乐视视频
$query = "{'ID':'1759997','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";

//  搜狐新闻
$query = "{'ID':'1716679','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";

//  百度贴吧
$query = "{'ID':'1729438','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  变形金刚:崛起
//  测试高清角标
$query = "{'ID':'1769988','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  腾讯微视
$query = "{'ID':'1767457','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  淘宝
$query = "{'ID':'1725970','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  echo回声
$query = "{'ID':'2007445','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
//  噬魂大掌门
//$query = "{'ID':'1672942','REQUIRE_PERMISSION':'0','KEY':'SOFT_DETAIL','VR':'".$VR."','SRC_POSITION':'-2'}";
login();
request($query);

//requestnew($query);

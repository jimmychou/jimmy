<?php
#gift.GoGetGiftMore
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$start = 0;
$size = 20;
login();
//$query = '{"KEY":"GIFTS_MORE","PACKAGE_NAME":"com.mykj.game.ddz","VR":"1","FROM":"4"}';
//$query = '{"KEY":"GIFTS_MORE","PACKAGE_NAME":"com.mykj.game.ddz","VR":"3","FROM":"4"}';
$query = '{"PACKAGE_NAME":"com.mykj.game.ddz","PATH":"1048576,1048577,1114112,27262981,6291456,6291463,6356992,6356993,17825792,17825793,17891328,17891336","VR":3,"KEY":"GIFTS_MORE"}';
request($query);

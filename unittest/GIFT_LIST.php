<?php
#gift.GoGetGiftList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$start = 0;
$size = 20;
login();
//$query = '{"KEY":"GIFT_LIST","TYPE":1,"LIST_INDEX_START":'.$start.',"LIST_INDEX_SIZE":'.$size.',"GIFT_TYPE":1,"VR":"3"}';
//$query = '{"KEY":"GIFT_LIST","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20", "VR":"2", "TYPE":0, "GIFT_TYPE":2, "FROM":4}';
$query = '{"KEY":"GIFT_LIST","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20", "VR":"3", "TYPE":0, "GIFT_TYPE":2, "FROM":4}';
request($query);

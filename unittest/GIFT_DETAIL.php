<?php
#gift.GoGetGiftDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$start = 0;
$size = 20;
login();
//$query = '{"KEY":"GIFT_DETAIL","GIFT_ID":"7","VR":"1"}';
$query = '{"KEY":"GIFT_DETAIL","GIFT_ID":"7","VR":"3"}';
request($query);

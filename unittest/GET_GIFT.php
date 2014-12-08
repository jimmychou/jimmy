<?php
#gift.GoGetGift
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$start = 0;
$size = 20;
login();
//$query = '{"KEY":"GET_GIFT","GIFT_ID":"7","IS_FIRST_REQUEST":"1","VR":"1","FROM":4}';
$query = '{"KEY":"GET_GIFT","GIFT_ID":"7","IS_FIRST_REQUEST":"1","VR":"3","FROM":4}';
request($query);

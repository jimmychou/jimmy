<?php
#v55.GoGetUnloginExchangeGiftinfo
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"GET_UNLOGIN_EXCHANGEGIFTINFO","VR":"1","GIFT_FROM":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20"}';
request($query);

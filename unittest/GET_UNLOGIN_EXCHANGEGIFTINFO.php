<?php
#v55.GoGetUnloginExchangeGiftinfo
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"GET_UNLOGIN_EXCHANGEGIFTINFO","VR":"1"}';
request($query);

<?php
#market.MarketPush
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'REQ_PUSH','LEVEL':'0','VR':'3'}";
request($query);

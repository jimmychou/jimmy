<?php
#market.GoGetMessageDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"MESSAGE_DETAIL","MESSAGEID":"326"}';
//$query = '{"KEY":"MESSAGE_DETAIL","MESSAGEID":"757"}';
$query = '{"KEY":"MESSAGE_DETAIL","MESSAGEID":"758"}';

//  two reply
$query = '{"PATH":"","MESSAGEID":803,"VR":1,"KEY":"MESSAGE_DETAIL"}';
request($query);

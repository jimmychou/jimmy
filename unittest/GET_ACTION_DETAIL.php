<?php
#v53.GoGetActivityById
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$actionid = 174;
$query = '{"KEY":"GET_ACTION_DETAIL","VR":"1","ACTIONID":"'.$actionid.'"}';
request($query);

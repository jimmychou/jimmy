<?php
#v53.GoGetBackAd
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$now = time();
$query = '{"KEY":"BACK_AD","VR":"1","TIMESTAMP":"'.$now.'"}';
request($query);

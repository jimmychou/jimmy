<?php
#v53.GoGetHomeSoaring
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$start = 100;
$size = 20;
$query = "{'KEY':'HOME_SOARING','LIST_INDEX_START':'".$start."','LIST_INDEX_SIZE':'".$size."','VR':'13'}";
request($query);

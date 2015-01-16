<?php
#softv2.GoGetExtentAd
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'HOME_EXTENT_AD','PATH':'/home/jimmychou/homeextendad','VR':'13','LIST_INDEX_START':'1','LIST_INDEX_SIZE':'20'}";
request($query);

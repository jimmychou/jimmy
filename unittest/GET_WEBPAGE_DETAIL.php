<?php
#v55.GoGetWebpageDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"GET_WEBPAGE_DETAIL","WEBPAGEID":"5","VR":"1"}';
request($query);

<?php
#v45.RecommendInstall
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"PATH":"","VR":14,"KEY":"RECOMMEND_INSTALL"}';
request($query);

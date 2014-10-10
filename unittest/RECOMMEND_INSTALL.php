<?php
#v45.RecommendInstall
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'RECOMMEND_INSTALL','VR':'2'}";
request($query);

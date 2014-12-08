<?php
#v53.GoGetRecommend
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"PATH":"13631488,1048576,1048577","VR":14,"KEY":"GET_RECOMMEND_NEW"}';
request($query);

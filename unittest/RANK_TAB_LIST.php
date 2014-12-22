<?php
#v55.GoGetRankTabList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"RANK_TAB_LIST","VR":"1"}';
request($query);

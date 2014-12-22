<?php
#v55.GoGetRankTabDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"RANK_APP_LIST","VR":"14","TAB_ID":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20"}';
request($query);

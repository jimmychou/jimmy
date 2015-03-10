<?php
#v55.GoGetRankTabDetail
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$tab_id = 4;
$start = 0;
$size = 20;
$query = '{"KEY":"RANK_APP_LIST","VR":"13","TAB_ID":"'.$tab_id.'","LIST_INDEX_START":"'.$start.'","LIST_INDEX_SIZE":"'.$size.'"}';
request($query);

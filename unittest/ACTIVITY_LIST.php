<?php
#v53.GoGetActivityList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"ACTIVITY_LIST","VR":"2","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20"}';
request($query);

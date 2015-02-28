<?php
//  日排行
#soft.GoGetSoftList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"ID":"1","LIST_INDEX_SIZE":20,"PATH":"3145728,3145731","VR":14,"KEY":"TOP_SUB_CATEGORY","LIST_INDEX_START":0,"TYPE":"1"}';
request($query);

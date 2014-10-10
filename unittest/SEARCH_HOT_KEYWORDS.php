<?php
#v45.SearchHotKeywords
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$time = time();
$query = "{'KEY':'SEARCH_HOT_KEYWORDS','VR':'3','TIMESTAMP':'".$time."'}";
request($query);

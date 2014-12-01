<?php
#soft.GoGetTopListAll
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'EBOOK_TOP_APP_LIST','LIST_INDEX_START':'0','LIST_INDEX_SIZE':'2','TYPE':'1','PATH':'0','VR':'10'}";
request($query);

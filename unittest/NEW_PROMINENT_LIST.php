<?php
#v53.GoGetNewProminentList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'NEW_PROMINENT_LIST','VR':'12'}";
request($query);

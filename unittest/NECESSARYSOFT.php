<?php
#soft.GoGetNecessaryExtent
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"NECESSARYSOFT","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20","VR":"11"}';
$query = '{"KEY":"NECESSARYSOFT","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20","VR":"14"}';
request($query);

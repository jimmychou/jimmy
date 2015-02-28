<?php
#v55.HotDepotAll
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"HOT_DEPOT_ALL","LIST_INDEX_START":"0","LIST_INDEX_SIZE","20","CATEGORY":"0","VR":"14"}';

//  尼玛逗号写成冒号


$query = '{"KEY":"HOT_DEPOT_ALL","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20","CATEGORY":"0","VR":"14"}';
request($query);

<?php
#skin.GoGetSkinList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"PATH":"","VR":2,"KEY":"SKIN_LIST_REQ","TIMESTAMP":0,"SSN":"8901260294928954545","REQUIRED_VERSION":5300}';
//$query = '{"PATH":"","VR":2,"KEY":"SKIN_LIST_REQ","TIMESTAMP":0,"SSN":"8901260294928954545","REQUIRED_VERSION":5400}';
$query = '{"PATH":"","VR":2,"KEY":"SKIN_LIST_REQ","TIMESTAMP":1413790722,"SSN":"8901260294928954545","REQUIRED_VERSION":5400}';
request($query);

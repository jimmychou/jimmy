<?php
//  favourate.GoPostFavourate

$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$ID = 1707755;
//$ID = 1762325;

$ID = 1550452;
$ID = 1640571;
$query = "{'KEY':'SUBMIT_PREFERENCES','ID':'".$ID."','PACKAGE_NAME':'org.cocos2dx.tests','VR':'5','REQ_INFO':'1','PASSTHROUGH':{'taskId':'23'}}";
$result = request($query);
//var_export($result);

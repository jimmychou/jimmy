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
//$ID = 1640571;
$query = "{'KEY':'SUBMIT_PREFERENCES','ID':'".$ID."','PACKAGE_NAME':'org.cocos2dx.tests','VR':'5','REQ_INFO':'1','PASSTHROUGH':{'taskId':'23'}}";
$query = '{"REQ_INFO":1,"VR":15,"PACKAGE_VERSIONNAME":"3.32","ID":1717184,"PATH":"1048576,1048577,1114112,9437187,17825792,17825793,17891328,17891334","KEY":"SUBMIT_PREFERENCES","PASSTHROUGH":{"taskId":"53"},"PACKAGE_NAME":"sina.mobile.tianqitong"}
';
$result = request($query);
//var_export($result);

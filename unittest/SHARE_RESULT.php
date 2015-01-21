<?php
#v55.GoShareResult
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"SHARE_RESULT","VR":"1","TYPE":1,"ID":"3","PASSTHROUGH":{"taskId":"25"}}';
$query = '{"KEY":"SHARE_RESULT","VR":"1","TYPE":1,"ID":"3","PASSTHROUGH":{"taskId":"1"}}';
request($query);

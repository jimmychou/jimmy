<?php
#v55.GoShareResult
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"SHARE_RESULT","VR":"1","TYPE":1,"ID":"1","PASSTHROUGH":{"taskId":"1","point":"34"}}';
request($query);

<?php
#message.list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"REPLY_MSG","USENAME":"jimmychou11","USEID":"22726146","SESSIONID":"492496","VR":"1","CONTENT":"What a fuck day,too!"}';
request($query);

<?php
#message.list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"SEND_MSG","USERNAME":"jimmychou11","VR":"1","CONTENT":"What a fuck day!"}';

//  jimmychou11 sendmessage to jimmychou12
$query = '{"PATH":"","USERNAME":"jimmychou12","VR":1,"KEY":"REPLY_MSG","CONTENT":"这个  看看","SESSIONID":"492523","USERID":"22726147"}';
request($query);

<?php
#message.msg_del
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"DEL_MSG","ID":"863338","VR":"1","TYPE":"2"}';
$query = '{"KEY":"DEL_MSG","ID":"863408","VR":"1","TYPE":"2"}';
$query = '{"ID":"492435","PATH":"","VR":1,"KEY":"DEL_MSG","TYPE":1}';
request($query);

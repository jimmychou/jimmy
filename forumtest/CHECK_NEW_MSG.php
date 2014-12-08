<?php
#message.msg_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"VR":1,"KEY":"CHECK_NEW_MSG"}';
request($query);

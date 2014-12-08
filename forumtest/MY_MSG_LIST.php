<?php
#message.msg_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"MY_MSG_LIST","VR":"1","LIST_INDEX_START":"4","LIST_INDEX_SIZE":"2"}';
//$query = '{"KEY":"MY_MSG_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"2"}';
//$query = '{"KEY":"MY_MSG_LIST","VR":"1","LIST_INDEX_START":"1","LIST_INDEX_SIZE":"10"}';
$query = '{"LIST_INDEX_SIZE":20,"PATH":"","VR":1,"KEY":"MY_MSG_LIST","LIST_INDEX_START":0}';
request($query);

<?php
#message.list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"BATCH_CALL","BATCH_REQ":[{"KEY":"MY_MSG_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"2"},{"KEY":"FAV_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"2"}]}';
request($query);

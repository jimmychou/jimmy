<?php
#favor.favor_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"FAV_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"2"}';
//$query = '{"KEY":"FAV_LIST","VR":"1","LIST_INDEX_START":"10","LIST_INDEX_SIZE":"10"}';
//$query = '{"KEY":"FAV_LIST","VR":"1","LIST_INDEX_START":"2","LIST_INDEX_SIZE":"30"}';
request($query);

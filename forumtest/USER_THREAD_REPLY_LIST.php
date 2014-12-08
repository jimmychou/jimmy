<?php
#favor.favor_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"LIST_INDEX_SIZE":20,"PATH":"","VR":1,"KEY":"USER_THREAD_REPLY_LIST","LIST_INDEX_START":0}';
request($query);

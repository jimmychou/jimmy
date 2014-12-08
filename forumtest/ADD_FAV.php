<?php
#favor.favor_add
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"ADD_FAV","VR":"1","ID":"9020432"}';
request($query);

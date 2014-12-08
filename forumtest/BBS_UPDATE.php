<?php
#favor.list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"BBS_UPDATE","VR":"1","SUPPLIERS":"0","VERSION_CODE":"2","SIGN":"whatafuck"}';
request($query);

<?php
#ucenter.sync_session
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
        ,'UID' => '22724586'
        ,'SID' => 'MjI3MjQ1ODZ8MTQxNTIzODMxNnwwMDd8TU9WRV9URVJNSU5BTHwyNTUwMTU=',
);
include 'common.php';
login();

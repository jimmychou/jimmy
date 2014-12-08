<?php
#ucenter.GoDoLoginNew
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
        ,'UID' => '7481712'
        //,'SID' => 'NzQ4MTcxMnwxNDEzMjY5NDY4fDAwN3xNT1ZFX1RFUk1JTkFMfDYzMDM0MQ=='
        ,'SID' => 'MjI3MjQ1ODZ8MTQxMzk1OTU0OXwwMDd8TU9WRV9URVJNSU5BTHw5Mjc0NzQ='
);
include 'common.php';
login();

<?php
#soft.GoGetSuggestBackup
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = "{'KEY':'MAYBE_LIKE_BACK_UP','PACKAGE_NAME':'user.anzhi.com.test','VR':'2'}";
request($query);

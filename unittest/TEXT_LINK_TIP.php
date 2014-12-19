<?php
#v53.GoGetTextLinkTip
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"TEXT_LINK_TIP","VR":"4"}';
request($query);

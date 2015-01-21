<?php
#v55.GoGetUnloginLotterydrawinfo
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"GET_UNLOGIN_LOTTERYDRAWINFO","VR":"1"}';
request($query);

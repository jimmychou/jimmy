<?php
#v55.GoGetPlugin
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"PKG_NAME":"com.anzhi.battleplatform","PATH":"","VR":13,"KEY":"GET_PLUGIN"}';
request($query);

<?php
#v55.GoGetPlugin
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//  $query = '{"KEY":"GET_PLUGIN","PKG_NAME":"com.hljxjpksy.chick","VR":"13"}';
$query = '{"PKG_NAME":"com.anzhi.battleplatform","PATH":"","VR":13,"KEY":"GET_PLUGIN"}';
request($query);

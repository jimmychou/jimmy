<?php
//$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN' : 'LOGIN';   //  pad not use this interface
$key = 'LOGIN';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();

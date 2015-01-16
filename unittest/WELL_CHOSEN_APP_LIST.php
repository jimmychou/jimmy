<?php
#v55.GoWellChosenAppList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"LIST_INDEX_SIZE":20,"PATH":"","VR":13,"KEY":"WELL_CHOSEN_APP_LIST","LIST_INDEX_START":0}';
request($query);

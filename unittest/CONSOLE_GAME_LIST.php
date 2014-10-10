<?php
#v53.GoGetConsoleGameList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"LIST_INDEX_SIZE":20,"PATH":"4194304,4194312","VR":13,"KEY":"CONSOLE_GAME_LIST","LIST_INDEX_START":0}';
request($query);

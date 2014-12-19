<?php
#soft.GoGetSoftSubjectAllList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"VR":13,"SRC_POSITION":0,"LIST_INDEX_SIZE":20,"ID":603,"PATH":"1048576,1048581,1835008,1835027","KEY":"SOFT_SUBJECT_ALL_LIST","LIST_INDEX_START":0,"TYPE":1}';
$query = '{"KEY":"SOFT_SUBJECT_ALL_LIST","VR":"14","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20","ID":"31","TYPE":"1"}';
request($query);

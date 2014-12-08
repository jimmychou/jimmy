<?php
#soft.GoGetCategoryAllSoftList
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"VR":13,"SRC_POSITION":-1,"ID":74,"LIST_INDEX_SIZE":20,"ORDER":1,"PATH":"26214400,26214402,26345472,26345473,26476544,26476546","KEY":"SOFT_CATEGORY_ALL_LIST","LIST_INDEX_START":0}';
request($query);

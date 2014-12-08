<?php
#favor.favor_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"FID":324,"PATH":"","VR":1,"KEY":"CATEGORY_LIST"}';
//$query = '{"FID":24,"PATH":"","VR":1,"KEY":"CATEGORY_LIST"}';
//$query = '{"FID":127,"PATH":"","VR":1,"KEY":"CATEGORY_LIST"}';  //  no  permission
$query = '{"FID":1223,"PATH":"","VR":1,"KEY":"CATEGORY_LIST"}';  // ROM 推广
request($query);

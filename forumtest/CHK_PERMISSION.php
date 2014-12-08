<?php
#favor.favor_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"CHK_PERMISSION","VR":"1","USER_ID":"22725254","TYPE":"2","FID":"334","TID":"0"}';
//$query = '{"KEY":"CHK_PERMISSION","VR":"1","USER_ID":"7275922","TYPE":"2","FID":"22"}';
$query = '{"FID":107,"PATH":"","VR":1,"KEY":"CHK_PERMISSION","USER_ID":"7722085","TYPE":1}';
request($query);

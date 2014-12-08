<?php
#favor.favor_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"THREAD_LIST","VR":"1","ID":"22","CATEGORY_ID":"0","ORDER":"0","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"4"}';
//$query = '{"KEY":"THREAD_LIST","VR":"1","ID":"22","CATEGORY_ID":"3","ORDER":"0","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"3"}';
//$query = '{"VR":1,"LIST_INDEX_SIZE":20,"ID":324,"ORDER":0,"PATH":" ","CATEGORY_ID":0,"KEY":"THREAD_LIST","LIST_INDEX_START":0}';
$query = '{"VR":1,"LIST_INDEX_SIZE":20,"ID":22,"ORDER":0,"PATH":"","CATEGORY_ID":0,"KEY":"THREAD_LIST","LIST_INDEX_START":0}';
request($query);

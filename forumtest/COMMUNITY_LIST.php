<?php
#forum.community_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$query = '{"KEY":"COMMUNITY_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20"}';
$query = '{"KEY":"COMMUNITY_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"10"}';
//  NOT OK
//$query = "{'KEY':'COMMUNITY_LIST','VR':'1','LIST_INDEX_START':'0','LIST_INDEX_SIZE':'10'}";
request($query);

<?php
#forum.community_more_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$ids = array(170,202,82,55);
//$ids = array(10086);
$ids = array(1111111);
foreach($ids as $ID){
    $query = '{"KEY":"COMMUNITY_MORE_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"10","ID":"'.$ID.'"}';
    request($query);
}

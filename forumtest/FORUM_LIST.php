<?php
#forum.community_more_list
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
//$ids = array(170,202,82,551,24);
$ids = array(24);
foreach($ids as $ID){
    $query = '{"KEY":"FORUM_LIST","VR":"1","LIST_INDEX_START":"0","LIST_INDEX_SIZE":"20","ID":"'.$ID.'"}';
//    request($query);
}

//  推荐专区
$query = '{"ID":"907","LIST_INDEX_SIZE":-1,"PATH":"","VR":1,"KEY":"FORUM_LIST","LIST_INDEX_START":0}';

//  最近访问
//$query = '{"LIST_INDEX_SIZE":5,"PATH":"","VR":1,"KEY":"FORUM_LIST","FORUM_IDS":["35","1204","747","25","782"],"LIST_INDEX_START":0}';
$query = '{"LIST_INDEX_SIZE":5,"PATH":"","VR":1,"KEY":"FORUM_LIST","FORUM_IDS":["1297","1314","1364","1358","174","128"],"LIST_INDEX_START":0}';

//  新游推荐
//$query = '{"ID":"932","LIST_INDEX_SIZE":-1,"PATH":"","VR":1,"KEY":"FORUM_LIST","LIST_INDEX_START":0}';

//  simple  test
//$query = '{"ID":"170","LIST_INDEX_SIZE":-1,"PATH":"","VR":1,"KEY":"FORUM_LIST","LIST_INDEX_START":0}';
//$query = '{"ID":"82","LIST_INDEX_SIZE":-1,"PATH":"","VR":1,"KEY":"FORUM_LIST","LIST_INDEX_START":0}';
request($query);

<?php
#favor.favor_del
$key = ($argv[1]=='hd.forum.anzhi.com') ? 'PAD_SYNC_SESSION' : 'SYNC_SESSION';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$ids = array(1217549);
/*
$query = '{"KEY":"DEL_FAV","ID":"'.json_encode($ids).'","VR":"1"}';
*/

$query = json_encode(array("KEY"=>"DEL_FAV"
                            ,"IDS"=>$ids
                            ,"VR"=>"1"
                            )
                    );
request($query);

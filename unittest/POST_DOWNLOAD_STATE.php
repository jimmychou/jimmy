<?php
#soft.GoPostDownloadLog
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"IS_DELTA":0,"STATE":0,"VR":4,"PARTNER_ID":0,"NET_TYPE":5,"ACTION_TYPE":1,"ACT_ID":-1,"ID":2083091,"ERROR_REASON":[["410","%s 已下架","","0","1113008","0","-1","0","0","",null,null,"0",null]],"PATH":"","KEY":"POST_DOWNLOAD_STATE","IS_SILENT":1,"PACKAGE_NAME":"com.anzhi.battleplatform"}';
request($query);

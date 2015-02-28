<?php
#soft.GoPostInstallLog
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$time = time();
//  中华万年历
//$query = '{"VCODE":461,"VR":6,"FROM_MARKET":0,"INSTALL_FAILED_CODE":0,"MD5":"6391fb0c06332b2b2a9ef6bc0e4a0fc4","ID":1658756,"PATH":"1048576,1048581,1835008,1835023,17825792,17825795,18022400,18022401","SOFT_INSTALL_STATE":1,"AUTO_INSTALL_FAILED_DESC":"","KEY":"SOFT_INSTALL","IS_SILENT":false,"PACKAGE_NAME":"cn.etouch.ecalendar","NATIVE_LOADED":1,"PASSTHROUGH":{"taskId":"1"}}';

//  MD5参数为空
$query = '{"VR":6,"FROM_MARKET":0,"INSTALL_FAILED_CODE":0,"MD5":"","PATH":"3145728,3145729,3211264,3211265,17825792,17825795,18022400,18022401","SOFT_INSTALL_STATE":1,"AUTO_INSTALL_FAILED_DESC":"","KEY":"SOFT_INSTALL","VCODE":7600,"ID":1977579,"PASSTHROUGH":{"taskId":"2"},"IS_SILENT":false,"PACKAGE_NAME":"com.sds.android.ttpod","NATIVE_LOADED":0}';
request($query);

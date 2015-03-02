<?php
#v45.GetMultiPartUrl
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"APP_SIZE":32426399,"VR":2,"PARTNER_ID":0,"PATH":"3145728,3145729,3211264,3211266","KEY":"REQ_MULTIPART_URL","INTEGERATE_URL":"http:\/\/am.apk.anzhi.com\/data2\/apk\/201501\/26\/3d9d7227a1a8cd56008ef5905032dd74_99864400.apk","TAG_ID":-1,"SRC_POSITION":0,"FILE_TYPE":1,"ID":2058235,"PACKAGE_NAME":"com.eg.android.AlipayGphone","NATIVE_LOADED":1,"TYPE":0,"CATE_ID":-1}';
request($query);

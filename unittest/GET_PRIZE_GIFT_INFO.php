<?php
#v55.GoGetPrizeGiftInfo
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
login();
$query = '{"KEY":"GET_PRIZE_GIFT_INFO","VR":"1","PACKAGE_NAME_ARRAY":["com.kibey.echo","com.hljxjpksy.chick","com.sookin.genebtbzgmzspw","game.mainyangyangta"]}';
$query = '{"KEY":"GET_PRIZE_GIFT_INFO","VR":"1","PACKAGE_NAME_ARRAY":["com.kibey.echo","com.hljxjpksy.chick","com.sookin.genebtbzgmzspw"]}';

//  回声的包有问题，因为没有sj_file的数据

$query = '{"KEY":"GET_PRIZE_GIFT_INFO","VR":"1","PACKAGE_NAME_ARRAY":["com.hljxjpksy.chick","com.sookin.genebtbzgmzspw"]}';
$query = '{"PATH":"","VR":1,"PACKAGE_NAME_ARRAY":"[\"com.tencent.weishi\",\"com.tencent.weishi\",\"com.tencent.weishi\",\"com.tencent.weishi\"]","KEY":"GET_PRIZE_GIFT_INFO"}';
$query = '{"PATH":"","VR":1,"PACKAGE_NAME_ARRAY":["com.tencent.weishi","com.tencent.weishi","com.tencent.weishi","com.tencent.weishi"],"KEY":"GET_PRIZE_GIFT_INFO"}';
request($query);

<?php
$ch = curl_init();
$token = 'token:'.base64_encode( json_encode( array( 'uid'=>'00000000-3228-21a6-cd54-bb8755b8f39e','chan'=>617,'vc'=>'19','inches'=>'8','os'=>'19' ) ) );

//	exclude some app from Nokia client
/*
curl_setopt( $ch, CURLOPT_URL, "http://api4.1mobile.com/myapps" );
curl_setopt( $ch, CURLOPT_HTTPHEADER, array( $token ) );

$exclude_pkgs = array( 'com.whatsapp','com.facebook.katana','com.skype.raider','com.twitter.android','co.vine.android','com.tencent.mm','com.outlook.Z7','jp.naver.line.android','com.picsart.studio','com.aes.contacttransfer','com.facebook.orca','com.viber.voip','com.bbm','com.microsoft.skydrive','com.metago.astro','com.gameloft.android.ANMP.GloftJDHM','com.appstudio.play.footballworldcup.free','com.ea.game.pvz2_row','com.ea.game.tetris2011_row','com.zing.zalo','com.yandex.browser','ru.yandex.yandexmaps','com.sonyliv','com.bt.bms','com.eterno','com.cleartrip.android','com.UCMobile.intl','com.qiyi.video.market','com.Qunar','com.chaozh.iReaderFree','com.autonavi.minimap','com.sina.weibo' );
foreach( $exclude_pkgs as $pkg ){

$post_data = array( 'uid'=>'ffffffff-c351-3e5d-68c8-4f6b0033c587'
		,'mode'=>0
		,'lasum'=>1
		,'auto'=>'false'
		,'appList'=>array(
			array('interName'=>$pkg,'interVersion'=>10,'status'=>1,'lastChangeTime'=>1394518899524 )
			)
	     );
curl_setopt( $ch, CURLOPT_POST,true );
curl_setopt( $ch, CURLOPT_POSTFIELDS,json_encode( $post_data ) );
*/

//	homepage
/*
curl_setopt( $ch, CURLOPT_URL, "http://api4.1mobile.com/apps/homepage/" );
curl_setopt( $ch, CURLOPT_HTTPHEADER, array( $token ) );
curl_setopt( $ch,CURLOPT_RETURNTRANSFER,true );
curl_setopt( $ch,CURLOPT_FOLLOWLOCATION,true );
curl_setopt($ch, CURLOPT_HEADER,true);//输出头信息
curl_setopt( $ch,CURLOPT_CUSTOMREQUEST,'GET' );
*/

//	download by area
/*
curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95/download?pkg=com.facebook.katana");// args是GET过去的
curl_setopt($ch, CURLOPT_HEADER,true);//输出头信息
curl_setopt($ch, CURLOPT_HTTPHEADER, array( $token ) );
*/


// analytics
/*
curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95:81/analytics");
curl_setopt($ch, CURLOPT_POST,true);
curl_setopt($ch, CURLOPT_POSTFIELDS,
		json_encode( array('analyticsData'=>array(
					"t=event&ht=137897038&ec=active&ea=value12&en=value13"
					,"t=event&ht=378917349387&ec=active&ea=value22&en=value23"
					,"t=event&ht=3897418998&ec=active&ea=value32&en=value33"
					,"t=pv&ht=38971207389&vn=homepage"
					,"t=log&ln=active&ht=38971207389&vn=homepage"
					) )
			)
	   );
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			'Basic-Info:dWlkPWZmZmZmZmZmLWMzNTEtM2U1ZC02OGM4LTRmNmIwMDMzYzU4NyZpbWVpPTM1OTYzMTA1MDY3NTIyMSZkbT1qZmx0ZSZwbj1vbmVtb2JpbGUuYW5kcm9pZC5hbmFseXRpY3MmbD1lbi11cyZhaWQ9MzgxZjU0MjZjYmEyNzdkNCZjdj0xLjAmY2lkPTkwMCZhdj0xOQ=='
			) );

*/

$ret = curl_exec($ch);
//}	//	for	foreach

//print_r( $ret );
//$info = curl_getinfo($ch);
//print_r( $info );
curl_close($ch);

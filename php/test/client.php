<?php
//$ch = curl_init();
//$header = array();
//$header[0] = "Accept: text/xml,application/xml,application/xhtml+xml,"; 
//$header[0] .= "text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"; 
/*
$header[] = "Cache-Control: max-age=0"; 
$header[] = "Connection: keep-alive"; 
$header[] = "Keep-Alive: 300"; 
$header[] = "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"; 
$header[] = "Accept-Language: en-us,en;q=0.5"; 
$header[] = "Pragma: "; // browsers keep this blank. 
curl_setopt( $ch,CURLOPT_HTTPHEADER,$header );

curl_setopt( $ch,CURLOPT_URL,"http://127.0.0.1/jimmychou/jimmy/php/test/server.php" );
curl_setopt( $ch,CURLOPT_COOKIE,"fruit:apple;vegetable:carrot" );
curl_exec( $ch );
curl_close( $ch );
*/
$ch = curl_init();

//	downurl

/*
curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95/?pkg=com.gameloft.android.ANMP.GloftUFHM&vc=112");
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                                        'token:eyJ1aWQiOiJmZmZmZmZmZi1jNTcwLWMyYjgtYzJmOC1hYTAwMDAzM2M1ODciLCJvcyI6MTksImNoYW4iOiI5MDAiLCJ2YyI6Mzk5OSwiaW5jaGVzIjoiOS4zIn0='
) );
*/

//	homepage

/*
//curl_setopt($ch, CURLOPT_URL, "http://api4.1mobile.com/apps/homepage/");
curl_setopt($ch, CURLOPT_URL, "http://api4.1mobile.com/apps/homepage/");
$token = 'token:'.base64_encode( json_encode( array( 'uid'=>'ffffffff-c351-3e5d-68c8-4f6b0033c587','imei'=>'359631050675221','dm'=>'jflte','pn'=>'onemobile.android.analytics','l'=>'en_US','aid'=>'381f5426cba277d4','cv'=>'1.0','cid'=>'900','av'=>'19','inches'=>'8' ) ) );
//$token = 'token:'.base64_encode( json_encode( array( 'uid'=>'ffffffff-c351-3e5d-68c8-4f6b0033c587','imei'=>'359631050675221','dm'=>'jflte','pn'=>'onemobile.android.analytics','l'=>'en_US','aid'=>'381f5426cba277d4','cv'=>'1.0','cid'=>'900','av'=>'19','inches'=>'6' ) ) );
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
$token
                                        //'token:eyJ1aWQiOiJmZmZmZmZmZi1jNTcwLWMyYjgtYzJmOC1hYTAwMDAzM2M1ODciLCJvcyI6MTksImNoYW4iOiI5MDAiLCJ2YyI6Mzk5OSwiaW5jaGVzIjoiOS4zIn0='
                                        //'token:dWlkPWZmZmZmZmZmLWMzNTEtM2U1ZC02OGM4LTRmNmIwMDMzYzU4NyZpbWVpPTM1OTYzMTA1MDY3NTIyMSZkbT1qZmx0ZSZwbj1vbmVtb2JpbGUuYW5kcm9pZC5hbmFseXRpY3MmbD1lbi11cyZhaWQ9MzgxZjU0MjZjYmEyNzdkNCZjdj0xLjAmY2lkPTkwMCZhdj0xOSZpbmNoZXM9OA=='
) );
#curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
#curl_setopt($ch,CURLOPT_FOLLOWLOCATION,true);
curl_setopt($ch,CURLOPT_HEADER,1);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
curl_setopt($ch,CURLOPT_FOLLOWLOCATION,1);
curl_setopt($ch,CURLOPT_CUSTOMREQUEST,'GET');
*/

// download
/*
//curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95/download");
curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95/download?pkg=com.facebook.katana");// args是GET过去的
curl_setopt($ch, CURLOPT_HEADER,true);//输出头信息
//curl_setopt($ch, CURLOPT_POST,true);
curl_setopt($ch, CURLOPT_POSTFIELDS,
//json_encode(array('pkg'=>'com.facebook.katana')
//)
//);

curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                                        'token:eyJ1aWQiOiJmZmZmZmZmZi1jNTcwLWMyYjgtYzJmOC1hYTAwMDAzM2M1ODciLCJvcyI6MTksImNoYW4iOiI5MDAiLCJ2YyI6Mzk5OSwiaW5jaGVzIjoiOS4zIn0='
) );
*/


//apk_download_by_group

//http://package.1mobile.com/download/en_304/ay/com.supercell.hayday_quickdownload_304.apk

/*
http:\/\/package.1mobile.com\/download\/en_304\/ay\/com.supercell.hayday_quickdownload_304.apk
*/


// analytics
/*
//curl_setopt($ch, CURLOPT_URL, "http://api4.1mobile.com/analytics");
//curl_setopt($ch, CURLOPT_URL, "http://api4.1mobile.com/index.php?act=analytics");
curl_setopt($ch, CURLOPT_URL, "http://42.62.23.95:81/analytics");

curl_setopt($ch, CURLOPT_POST,true);
curl_setopt($ch, CURLOPT_POSTFIELDS,
		json_encode(array('analyticsData'=>array(
					"t=event&ht=137897038&ec=active&ea=value12&en=value13"
					,"t=event&ht=378917349387&ec=active&ea=value22&en=value23"
					,"t=event&ht=3897418998&ec=active&ea=value32&en=value33"
					,"t=pv&ht=38971207389&vn=homepage"
					,"t=log&ln=active&ht=38971207389&vn=homepage"
					))
			)
	   );
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			//'token:eyJ1aWQiOiJmZmZmZmZmZi1jNTcwLWMyYjgtYzJmOC1hYTAwMDAzM2M1ODciLCJvcyI6MTksImNoYW4iOiI5MDAiLCJ2YyI6Mzk5OSwiaW5jaGVzIjoiOS4zIn0='
			//,'Basic-Info:uid=ffffffff-c570-c2b8-c2f8-aa000033c587&imei=00000000000000&dm=vbox86tp&pn=me.onemobile.lite.two&l=en-us&aid=f00d291d23655247&cv=3.9.9.9&cid=900&av=19'
			'Basic-Info:dWlkPWZmZmZmZmZmLWMzNTEtM2U1ZC02OGM4LTRmNmIwMDMzYzU4NyZpbWVpPTM1OTYzMTA1MDY3NTIyMSZkbT1qZmx0ZSZwbj1vbmVtb2JpbGUuYW5kcm9pZC5hbmFseXRpY3MmbD1lbi11cyZhaWQ9MzgxZjU0MjZjYmEyNzdkNCZjdj0xLjAmY2lkPTkwMCZhdj0xOQ=='
			) );
*/

/*
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                                        'token'=>'eyJ1aWQiOiJmZmZmZmZmZi1jNTcwLWMyYjgtYzJmOC1hYTAwMDAzM2M1ODciLCJvcyI6MTksImNoYW4iOiI5MDAiLCJ2YyI6Mzk5OSwiaW5jaGVzIjoiOS4zIn0='
										//,'Basic-Info'=>'uid=87654321&aid=1234678&av=4.42&imei=2834872342304023&l=zh_CN&dm=Nexus5&cv=3.9.9.6&pn=me.onemobile.android&cid=100'
										,'Basic-Info'=>'uid=ffffffff-c570-c2b8-c2f8-aa000033c587&imei=00000000000000&dm=vbox86tp&pn=me.onemobile.lite.two&l=en-us&aid=f00d291d23655247&cv=3.9.9.9&cid=900&av=19'
) );
*/

//test_header

/*
curl_setopt($ch, CURLOPT_URL, "http://test.1mobile.com/1mobile/www/apicdn/index.php?act=analytics");
//curl_setopt($ch, CURLOPT_URL, "http://test.1mobile.com/1mobile/www/apicdn/index.php");
curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
										'uid:87654321'
										,'aid:1234678'
										,'av:4.42'
										,'imei:2834872342304023'
										,'l:zh_CN'
										,'dm:Nexus5'
										,'cv:3.9.9.6'
										,'pn:me.onemobile.android'
										,'cid:100'
) );
*/
/*
//curl_setopt($ch, CURLOPT_URL, "http://down.1mobile.com/?pkg=com.facebook.katana");//403是因为配置没有加	index  index.html index.htm index.php;
//curl_setopt($ch, CURLOPT_URL, "http://down.1mobile.com/index.php?pkg=com.facebook.katana");
curl_setopt($ch, CURLOPT_URL, "http://down.1mobile.com/admin.php?pkg=com.facebook.katana");
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
										'token:87654321'
) );
*/
$ret = curl_exec($ch);
print_r( $ret );
$info = curl_getinfo($ch);
print_r( $info );
curl_close($ch);

<?php
include 'global.php';
//$string = "可不可以别这么搞！\n";
//echo $string."\n";
//print_r( chkbm( $string ) );

#Status
header( "Status: 100 go on shaonian" );


#Cache-Control

#header( "Cache-Control","no-cache" );	//	这样是错误的，整体是一个字符串
header( "Cache-Control:max-age=90" );
#header( "Pragma: no-cache" );	//	1.0同Cache-Control
#header( "Cache-Control: no-cache" );


#Content-Type

#header( "Content_type: text/xml" );	//	这样是错误的，大小写丝毫不能错误，而且中划线不能写成下划线
#header( "Content-Type: text/xml" );
#header( "Content-Type: text/plain" );
#header( "Content-Type: image/jpeg" );
#header( "Content-Type: application/json" );
#header( "Content-Type: audio/x-mpeg" );
#header( "Content-Type: application/pdf" );
#header( "Content-Type: application/octet-stream" );
#header( "Content-Type: application/msword" );
#header( "Content-Type: application/vnd.ms-powerpoint" );
#header( "Content-Type: application/x-javascript" );
#header( "Content-Type: application/x-shockwave-flash" );

#header( "Content-Type: text/html;charset=GB2312" );
#header( "Content-Type: text/html;charset=utf8" );


#Content-Language

#header( "Content-Language: en" );
header( "Content-Language: big5" );

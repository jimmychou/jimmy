<?php
require 'Snoopy.class.php';
$snoopy = new Snoopy;
//$snoopy->proxy_host = "www.baidu.com";
$snoopy->proxy_host = "localhost";
//$snoopy->proxy_port = "8080";
$snoopy->proxy_port = "80";
$snoopy->agent = "(compatible; MSIE 4.01; MSN 2.5; AOL 4.0; Windows 98)";
//$snoopy->referer = "http://www.baidu.com/";
$snoopy->referer = "http://localhost/jimmychou/jimmy/index.php";
$snoopy->cookies["SessionID"] = '238472834723489l';
$snoopy->cookies["favoriteColor"] = "RED";
$snoopy->rawheaders["Pragma"] = "no-cache";
$snoopy->maxredirs = 2;
$snoopy->offsiteok = false;
$snoopy->expandlinks = false;
$snoopy->user = "joe";
$snoopy->pass = "bloe";
//if( $snoopy->fetchtext( "http://www.baidu.com" ) ){
if( $snoopy->fetchtext( "http://localhost/jimmychou/jimmy/php/http/request.php" ) ){
	echo " ".htmlspecialchars( $snoopy->results )."\n";
}
else{
	echo "error fetching document: ".$snoopy->error."\n";
}

<?php
$ch = curl_init();
$header = array();
$header[0] = "Accept: text/xml,application/xml,application/xhtml+xml,"; 
$header[0] .= "text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"; 
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

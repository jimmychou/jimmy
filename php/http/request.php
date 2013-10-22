<?php
//$now = date("Y-m-d H:i:s",time()-60);
//$now = date("D,d m Y H:i:s e",time()-60);
//echo "now=$now\n";
include('global.php');
$ch = curl_init();
//print_r( curl_version() );
$request_header = array(
	 "Accept: application/json"
	//,"Accept-Charset: gb2312"
	,"Accept-Charset: big5"
	//,"Accept-Language: big5"
	,"Accept-Language: en"
	//,"If-Modified-Since: $now"
	,"Connection: close"
	,"User-agent: Curl"
	,"Accept-Encoding: gzip,deflate"
	);
curl_setopt( $ch,CURLOPT_HTTPHEADER,$request_header );

curl_setopt( $ch,CURLOPT_HEADER,true );//输出响应头
#curl_setopt( $ch,CURLOPT_FOLLOWLOCATION,true );//启用时会将服务器服务器返回的"Location: "放在header中递归的返回给服务器，使用CURLOPT_MAXREDIRS可以限定递归返回的数量。

//curl_setopt( $ch,CURLOPT_PORT,8080 );//限定端口，改为8080即为apache


//curl_setopt( $ch,CURLOPT_URL,'http://ditu.google.cn' );//204
//curl_setopt( $ch,CURLOPT_URL,REQUEST_PREFIX.'jimmychou/jimmy/php/http/transfer.php' );
//curl_setopt( $ch,CURLOPT_URL,REQUEST_PREFIX.'jimmychou/jimmy/php/http/test1.png' );
//curl_setopt( $ch,CURLOPT_URL,REQUEST_PREFIX.'jimmychou/jimmy/index.php' );
curl_setopt( $ch,CURLOPT_URL,REQUEST_PREFIX.'jimmychou/jimmy/php/http/index.php' );

curl_setopt( $ch,CURLOPT_USERAGENT,'Moniter of Curl' );//会被覆盖掉

echo '<pre>';
$ret = curl_exec( $ch );
curl_close( $ch ); 
//print_r( $ret );
echo "\n";
/*
$file = $_GET['file']; // "../../etc/passwd\0"
echo "the file is $file\n";
if (file_exists('/home/jimmychou/'.$file.'.php')) {
    // file_exists will return true as the file /home/wwwrun/../../etc/passwd exists
    include '/home/jimmychou/'.$file.'.php';
echo "haha!crackok";
    // the file /etc/passwd will be included
}
*/
/*
echo '<pre>';
print_r( $GLOBALS );
print_r( $_SESSION );
print_r( $_ENV );
print_r( $php_errormsg );
print_r( $HTTP_RAW_POST_DATA );
print_r( $http_response_header );
*/

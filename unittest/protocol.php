<?php
/*
// Set the limit to 5 MB.
$fiveMBs = 5 * 1024 * 1024;
$fp = fopen("php://temp/maxmemory:$fiveMBs", 'r+');

fputs($fp, "hello\n");

// Read what we have written.
rewind($fp);
echo stream_get_contents($fp);
*/

$url = 'http://www.baidu.com/index.php';
$fp = fopen($url,'r');
$meta_data = stream_get_meta_data($fp);
foreach ($meta_data['wrapper_data'] as $response){
    /* 我们是否被重定向了？ */
    if (strtolower(substr($response, 0, 10)) == 'location: '){
        /* 更新我们被重定向后的 $url */
        $url = substr($response, 10);
    }
}
echo "url=$url\n";

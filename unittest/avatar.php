<?php
function curl_post($url,$data){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    $output = curl_exec($ch);
    curl_close($ch);
    return $output;
}
//$binary = file_get_contents("/home/jimmychou/workspace/jimmy/php/image.jpg");
$binary = file_get_contents("/home/jimmychou/workspace/jimmy/php/icon1.png");
$base_url = "http://192.168.4.232/uc_avatar.php";
$res = curl_post($base_url, $binary);
print_r($res);

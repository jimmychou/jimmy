<?php
function curl_post($url,$data){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_VERBOSE, true);
    $output = curl_exec($ch);
    $info = curl_getinfo($ch);
//    print_r($info);
    curl_close($ch);
    return $output;
}
/*
$key = ($argv[1]=='hd.goapk.com') ? 'PAD_LOGIN_NEW' : 'LOGIN_NEW';
$login_key = array(
        'KEY' => $key
);
include 'common.php';
$login_data = login();
*/
//print_r($login_data);exit;
//$_SESSION['pid'] = 
$binary = file_get_contents("/home/jimmychou/workspace/jimmy/php/image.jpg");
$base_url = "http://gomarket.goapk.com/uc_avatar.php";
$res = curl_post($base_url, $binary);
//print_r($res);

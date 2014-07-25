<?php
function curl_get($url,$debug=false){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HEADER, true);    //  将返回的head打印出，在body为空时相当有用
//    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); //  递归重定向
//    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
    curl_setopt($ch, CURLOPT_VERBOSE, true);    //  加上这一项看出来是local.anzhi.com域名解析的问题
    $output = curl_exec($ch);
    if($debug){
        $info = curl_getinfo($ch);
        print_r($output);
        print_r($info);
    }
    curl_close($ch);
    return $output;
}
$data = array('pid'=>21376912,'size'=>'small');
$debug = true;
$base_url = "http://user.anzhi.com/api/obtain/album?".http_build_query($data);
$res = curl_get($base_url,$debug);
//print_r($res);

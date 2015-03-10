<?php
function curl_post($url,$data){
    $ch = curl_init();

        $header = array(
//            'Content-Type:  application/x-www-form-urlencoded;charset=utf-8',
            'Cache-Control: public,max-age=500',
            'If-Modified-Since:  Thu, 8 Oct 2014 00:00:00 GMT',
//            'If-Modified-Since:  Sat, 11 Oct 2014 00:00:00 GMT',
            );

    //  bool
    curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);    //  全部数据使用HTTP协议中的"POST"操作来发送。要发送文件，在文件名前面加上@前缀并使用完整路径。这个参数可以通过urlencoded后的字符串类似'para1=val1&para2=val2&...'或使用一个以字段名为键值，字段数据为值的数组。如果value是一个数组，Content-Type头将会被设置成multipart/form-data。
    //  设置为true时影响$_FILES

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);    //  CURLOPT_RETURNTRANSFER 将 curl_exec()获取的信息以文件流的形式返回，而不是直接输出。
//    curl_setopt($ch, CURLOPT_NOPROGRESS, false);    //  CURLOPT_NOPROGRESS 启用时关闭curl传输的进度条，此项的默认设置为启用。
     
//    curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);   // CURLOPT_BINARYTRANSFER 在启用CURLOPT_RETURNTRANSFER的时候，返回原生的（Raw）输出。 
    curl_setopt($ch, CURLOPT_HEADER, true); //  输出响应头
//    curl_setopt($ch, CURLINFO_HEADER_OUT, true); //  
    
    
    curl_setopt($ch, CURLOPT_PORT, 80);    //  CURLOPT_PORT 用来指定连接端口。（可选项） 


//    curl_setopt($ch, CURLOPT_VERBOSE, true);


    $output = curl_exec($ch);
    $info = curl_getinfo($ch);
//    print_r($info);
    curl_close($ch);
    return $output;
}
$base_url = "http://centos.jimmychou.com/index.php";
for($i=0;$i<1;$i++){
    $res = curl_post($base_url, array('ok'=>"ok"));
    print_r($res);
}

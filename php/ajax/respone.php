<?php
header('Content-type: text/html; charset=utf-8');
if( $_REQUEST ){
    $ret ="Request exsited are ".json_encode( $_REQUEST )."\n";
    echo $ret;
//    return $ret;  //不能用return的方式返回
}
else{
    $now = time();
    $TM = date( "Y-m-d H:i:s",$now );
    $ret = "There is no request at all and the current time is $now and the formated time is $TM\n";
    echo $ret;
//    return $ret;  //不能用return的方式返回
}

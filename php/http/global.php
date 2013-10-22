<?php
define( 'REQUEST_PREFIX','http://10.1.73.16/' );
define( 'TRANSFER_PREFIX','http://10.1.73.16/' );
function chkbm( $string ){
    $bm = array( 'ASCII','GBK','UTF-8' );
    foreach( $bm as $c ){
        if( $string === iconv( 'UTF-8',$c,iconv( $c,'UTF-8',$string ) ) ){//转换编码后是不是相等
            return $c;
        }
    }
    return null;
}

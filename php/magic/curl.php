<?php
if( isset( $_REQUEST['nice'] ) ){
    $ret = json_encode( $_REQUEST );
    echo $ret;
	exit;
}
echo 'there is nothing';
//return $ret;
exit;
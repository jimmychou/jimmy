<?php
require_once __DIR__.'/base.php';
require_once __DIR__.'/JsonServer.php';
/*
if(IS_PRODUCTION==0){
    JsonServer::$test_data_dir=__DIR__.'/../../support/help/testdata.bak/';
}
*/
try{
	$server= new JsonServer();
//	print_r( $server );
	echo $server->handle();
}
catch (Exception $e)
{
	$ret['s']='KO';
	$ret['msg']=$e->getMessage();
	echo json_encode($ret);
}
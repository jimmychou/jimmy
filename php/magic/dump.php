<?php
/*
//dump
	function cost( $start,$end )
	{
		$start = explode( ' ',$start );
		$end = explode( ' ',$end );
		$cost = $end[0] - $start[0] + $end[1] - $start[1];
		return $cost;
	}
	
	$start = microtime();
		$link = mysql_connect(  '192.168.1.254','root','admin' );
		if( !$link ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet mysql fail'.mysql_error();
			echo json_encode( $ret );
			return;
		}
		$con = mysql_select_db( 'wicamp', $link );
		if( !$con ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet db fail'.mysql_error();
			echo json_encode( $ret );
			return;
		}
	
//        $sql = 'select * from wicamp_users_buildings';
		$sql = 'select * from wicamp_users_buildings where ub_id = 1';        
		$last = mysql_query( $sql,$link );
		if( !$last ){
			$ret['status'] = 'query';
			$ret['statusinfo'] = 'query db fail'.mysql_error();
			echo json_encode( $ret );
			return;			
		}
		while ( $row = mysql_fetch_object( $last ) ) {
//		    print_r( $row );
//			$ret['server'][ $row->user_id ] = C('LOGIN_SERVER_PRE').$row->server_id.C('LOGIN_SERVER_SUF');
		}
		$ret['status'] = 'ok';
		mysql_close( $link );
		echo json_encode( $ret );
		$end = microtime();
		$cost = cost( $start,$end );
		echo "\ntotaly cost $cost second\n";		
		return;
		*/
		

$start = session_start();
if( !$start ){
    echo "failed\n";
	exit;
}
$sess = session_id();
echo "session is $sess\n";
print_r( $_SESSION );
//$sess = 'rej326oqvketko6cjl5pasj362';
<?php
class Test
{
	private function cost( $start,$end )
	{
		$start = explode( ' ',$start );
		$end = explode( ' ',$end );
		$cost = $end[0] - $start[0] + $end[1] - $start[1];
		return $cost;
	}

	public function init_db()
	{
		$start = microtime();
		$_host = 'localhost';
		$_db = 'loginserver';
		$_user = 'root';
		$_password = '';

		$link = mysql_connect( $_host,$_user,$_password );
		if( !$link ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet mysql fail';
			echo json_encode( $ret );
			exit;
		}
		$con = mysql_select_db( $_db, $link );
		if( !$con ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet db fail';
			echo json_encode( $ret );
			exit;
		}		
		$table = 'user_id';
		$max = 100000;	
		for( $i=1;$i<=$max;$i++ ){  // 100 thousand for test
			$username = "h$i";
			$server_id = ceil( $i/50000 );
			$sql = "insert into $table ( username,server_id ) values ( '$username',$server_id )";
			$success = mysql_query( $sql,$link );
			if( !$success ){
				$ret['status'] = 'duplicat';
				$ret['statusinfo'] = mysql_error();
				echo json_encode( $ret );
				exit;
			}
			if( $i%1000 == 0 ){
				//				echo "$i records inserted\n";
			}
		}
		$end = microtime();
		$cost = $this->cost( $start,$end );
		echo "totaly cost $cost second\n";
	}

	public function select( $sql=null ){
		$start = microtime();
		$_host = 'localhost';
		$_db = 'loginserver';
		$_user = 'root';
		$_password = '';
		$b_mem = ceil( memory_get_usage( true ) / 1024 );
		echo "use $b_mem K at the beginning\n";
		$link = mysql_connect( $_host,$_user,$_password );
		if( !$link ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet mysql fail';
			echo json_encode( $ret );
			exit;
		}
		$con = mysql_select_db( $_db, $link );
		if( !$con ){
			$ret['status'] = 'fail';
			$ret['statusinfo'] = 'conneet db fail';
			echo json_encode( $ret );
			exit;
		}
		if( !$sql ){
		$table = 'user_id';
			$sql = "select * from $table";
		}
		$result = mysql_query( $sql,$link );
		if( !$result ){
			$ret['status'] = 'select';
			$ret['statusinfo'] = mysql_error();
			echo json_encode( $ret );
			exit;
		}
		$selected = array();
		$keyword = 'nice';
		while( $row = mysql_fetch_array( $result, MYSQL_ASSOC ) ) {
			if( strpos( $row['username'],$keyword ) ){
				$selected[] = $row['username'];
			}
		}
		print_r( $selected );
		$e_mem = ceil( memory_get_usage( true ) / 1024 );
		echo "use $e_mem K in the end\n";
		$end = microtime();
		$cost = $this->cost( $start,$end );
		echo "totaly cost $cost second\n";
	}
}

$test = new Test();
//$test->init_db();
//$test->select();
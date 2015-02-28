<?php
class Tools
{
	public function mb_str_split( $string, $split_length = 1 ){
		mb_internal_encoding('UTF-8'); 
		mb_regex_encoding('UTF-8');  
		$split_length = ($split_length <= 0) ? 1 : $split_length;
		$mb_strlen = mb_strlen($string, 'utf-8');
		$array = array();
		for( $i=0,$j=0;$i<$mb_strlen;$i+=$split_length ){
			//$array[] = mb_substr( $string,$i,$split_length ); 
			//$array[$j] = mb_substr( $string,$i,$split_length );
			$single = mb_substr( $string,$i,$split_length );
			$array[$j] = $single;
			$j++;
		}
		return $array;
	}
	//人人网一个把 "I love this game" 倒转成 "game this love I"
	public function renren_reverse( $str,$mode=1 )
	{
		if( $mode == 1 ){
			//$str_array = self::mb_str_split( $str,1 );
			$str_array = self::mb_str_split( $str,1 );
			krsort( $str_array );
			return $str_array;
		}
		elseif( $mode == 2 ){
			$str_array = explode( " ",$str );
			krsort( $str_array );
			return $str_array;
		}
		//2014.06.13	add	below
		//explode by ' ' then array_reverse and implode at last 
	}
	public function __autoload( $classname )
	{
		//    require_once ( $classname.'.class.php' );
	}
	//$person = new Person( 'Altair', 6 );
	//var_dump ( $person );

	public function stick_convert( $string )
	{
		// 强制类型转换
		$intval = intval( $string );
		echo 'string='.$string.' and type is '.gettype( $string ).' and intval='.$intval.' and type is '.gettype( $intval )."\n";
	}

	public function xref_count()
	{
		//$a = array( 'meaning' => 'life', 'number' => 42 );
		//$a = 'Hello World!';
		//xdebug_debug_zval( 'a' );
		$a = "new string";
		xdebug_debug_zval( 'a' );
		$b = $a;
		xdebug_debug_zval( 'a' );
		xdebug_debug_zval( 'b' );
		$c = $a;
		xdebug_debug_zval( 'a' );
		xdebug_debug_zval( 'b' );
		xdebug_debug_zval( 'c' );
		$d = &$a;
		//$d = $a;
		xdebug_debug_zval( 'a' );
		xdebug_debug_zval( 'b' );
		xdebug_debug_zval( 'c' );
		xdebug_debug_zval( 'd' );
		//unset( $a );
		unset( $b );
		xdebug_debug_zval( 'a' );
		xdebug_debug_zval( 'b' );
		xdebug_debug_zval( 'c' );
		xdebug_debug_zval( 'd' );
	}

	public function ref_count()
	{
		$test = 'wahaha';
		debug_zval_dump( $test );
		$test = '';
		debug_zval_dump( $test );
		debug_zval_dump( $test );
		debug_zval_dump( $test );
		debug_zval_dump( $test );
		debug_zval_dump( $test );
		debug_zval_dump( $test );
		echo "\n";
		$a = 1;
		$b = 2;
		//$b = $a;
		debug_zval_dump($a)."\n";
		debug_zval_dump($b)."\n";
		//xdebug_debug_zval($a)."\n";
		//require_once ('a.php');
	}

	public function strange_int()
	{
		echo (int) ( (0.1+0.7) * 10 )."\n";
	}
	// array_intersect,array_intersect_assoc,array_diff,array_diff_assoc等四个区别取值函数，array_intersect和array_diff相同，保留键名时，与第一个数组里的键值相等。
	// array_slice,array_splice等两个拆分函数注意 array_slice的第四个参数
	// array_combine,array_merge,array_merge_recursive等三个合并函数以及+的区别
	// array_fill

	//print_r( htmlspecialchars( 'http://www.baidu.com' ) );
	public function merge_error()
	{
		$temp = array();
		//$temp = null;
		$temp = array_merge( $temp,array( 'user_id'=>1 ) );
		print_r( $temp );
	}

	// for phpredis library
	public function phpredis_lib()
	{
		echo 'size is '.strlen( json_encode( array( 'r'=>4,'id'=>1,'exp'=>4,'t'=>1231531513 ) ) )."\n";
		echo 'size is '.strlen( "4,1,4,1231531513" )."\n";
		$redis = new Redis();
		$redis->connect( '127.0.0.1',36000 );
		$redis->connect( '127.0.0.1',6379,2 );
		$key = "1:user";
		$datas = $redis->hgetall( $key );
		if( !empty( $datas ) ){
			echo "the datas before auth are :\n";
			print_r( $datas );
		}
		$auth = $redis->auth( 'f43eea2a1a2d61689a7113d340b011ae' );
		if( $auth ){
			echo "the auth result is :\n";
			print_r( $auth );
			echo "\nauth passed\n";
		}
		else{
			echo "\nauth nopassed\n";
		}
		$datas = $redis->hgetall( $key );
		if( !empty( $datas ) ){
			echo "the datas after auth are :\n";
			print_r( $datas );
		}
		$keys = $redis->keys( '*' );
		print_r( $keys );
		print_r( array( 1=>Redis::REDIS_STRING,2=>Redis::REDIS_SET,3=>Redis::REDIS_LIST,4=>Redis::REDIS_ZSET,5=>Redis::REDIS_HASH,0=>Redis::REDIS_NOT_FOUND ) );
		$all_datas = array();
		foreach( $keys as $index=>$key ){
			$type = $redis->type( $key );
			if( $type == Redis::REDIS_STRING ){
				echo "\n the $index th data whose key is $key is type of string:\n";
				$data = $redis->get( $key );
				print_r( $data );
				$all_datas[$key] = $data;
			}
			elseif( $type == Redis::REDIS_SET ){
				echo "\n the $index th data whose key is $key is type of set:\n";
				$data = $redis->hgetall( $key );
				print_r( $data );
				$all_datas[$key] = $data;
			}
			elseif( $type == Redis::REDIS_LIST ){
				echo "\n the $index th data whose key is $key is type of list:\n";
				$data = $redis->lrange( $key,0,-1 );
				print_r( $data );
				$all_datas[$key] = $data;
			}
			elseif( $type == Redis::REDIS_ZSET ){
				echo "\n the $index th data whose key is $key is type of zset:\n";
				$data = $redis->zrange( $key,0,-1 );
				print_r( $data );
				$all_datas[$key] = $data;
			}
			elseif( $type == Redis::REDIS_HASH ){
				echo "\n the $index th data whose key is $key is type of hash:\n";
				$data = $redis->hgetall( $key );
				print_r( $data );
				$all_datas[$key] = $data;
			}
			elseif( $type == Redis::REDIS_NOT_FOUND ){
			}
		}
		print_r( $all_datas );
	}
	//!与empty的区别
	public function check_empty( $data )
	{
		if( empty( $data ) ){
			echo "it's empty\n";
		}
		else{
			echo "it's not empty\n";
		}
	}
	public function check_value( $data )
	{
		if( !$data ){
			echo "it has no data\n";
		}
		else{
			echo "it has data\n";
		}
	}
	public function test_value()
	{
		$martrix = array();
		check_empty( $martrix );
		check_value( $martrix );
		//$martrix = array_fill( 0,5,0 );
		$martrix = array_fill( 0,5,'ok' );
		check_empty( $martrix );
		check_value( $martrix );
		print_r( $martrix );
		$var = array('staus'=>0);
		if(!empty($var)){
			echo 'notempty';
		}
		else{
			echo 'empty';
		}
	}
	public function andor()
	{
		echo $a = decbin( 12 ) . "\n";
		echo $b = decbin( 26 ) . "\n";
		echo $c = $a & $b . "\n";
		echo $c = $a | $b . "\n";
		echo $d = $a | $b . "\n";
		echo 12 ^ 9; // 输出为 '5'
		echo 'the current DIR is '.__DIR__."\n";
		echo 'the current NAMESPACE is '.__NAMESPACE__."\n";
		echo 'the current FILE is '.__FILE__."\n";
		echo 'the current FUNCTION is '.__FUNCTION__."\n";
		echo 'the current LINE is '.__LINE__."\n";
		echo 'the current CLASS is '.__CLASS__."\n";
		echo 'the current METHOD is '.__METHOD__."\n";
		echo "12" ^ "9"; // 输出退格字符（ascii 8） // ('1' (ascii 49)) ^ ('9' (ascii 57)) = #8
		echo "hallo" ^ "hello";                     // 输出 ascii 值 #0 #4 #0 #0 #0// 'a' ^ 'e' = #4
		echo 2 ^ "3";    // 输出 1                  // 2 ^ ((int)"3") == 1
		echo "2" ^ 3;    // 输出 1                  // ((int)"2") ^ 3 == 1  
		echo "Hello world!����ʲô������\n";
		echo "Hello world!2这是什么啊！！\n";
		echo substr( '这他妈是些什么东西啊！',0,7 )."\n";
	}
	public function inverse($x)
	{
		if (!$x) {
			throw new Exception('Division by zero.');
		}
		else return 1/$x;
	}
	public function test_inverse()
	{
		try{
			echo inverse( 5 ) . "\n";
			echo inverse( 0 ) . "\n";
		} 
		catch( Exception $e ){
			echo 'Caught exception: ',  $e->getMessage(), "\n";
		}
	}
	public function diff_array_merge()
	{
		$arr1 = array('a', 'b', 'c', 'd', 'e');
		$arr2 = array('a', 'b', 'c', 'd', 'e','f','g');
		print_r( array_merge( $arr1,$arr2 ) );
		print_r( array_merge( $arr2,$arr1 ) );
		$arr3 = $arr1 + $arr2;
		print_r( $arr3 );
	}
	public function get_time()
	{
		$timezone = date_default_timezone_get();
		echo "你的电脑使用时区为$timezone\n";
		$now = time();
		$now = date("Y-m-d H:i:s D l j N S w z W F a B e I O P T Z c r U",$now);
		echo "现在时刻$now\n";
	}
	public function utf8()
	{
		$utf8 = "\u53c2\u6570\u9519\u8bef";
		//$utf8 = "what a shit!";
		echo "$utf8\n";
		//        $ori = unicode_decode( $utf8 );
		//        echo "$ori\n";
		//print u'\u53c2\u6570\u9519\u8bef'
	}
	public function stringandbinary()
	{
		$string = 100;
		$bin = pack( 'I',$string );
		//$bin = pack( "nvc*", 0x1234, 0x5678, 65, 66 );
		echo "string = $string and bin = $bin \n";
		//file_put_contents( "bin",$bin,FILE_APPEND );
		//file_put_contents( "string",$string,FILE_APPEND );

		//print_r( unpack("c2chars/nint", $binarydata ) );
		echo system( 'od data/bin ');
		echo system( 'od data/string' );
	}
	// Memcached
	public function test_memcached()
	{
		$m = new Memcached();
		echo get_class( $m )."\n";
		$servers = array(
			//	array( 'localhost',11210,33 ),
			array( 'localhost',11210 ),
			);
		$add = $m->addServers( $servers );
		if( !$add ){
			echo "connect faild!\n";
			exit;
		}
		echo "connect successful\n";
		$stat = $m->getStats();
		print_r( $stat );
		$set = $m->set('int', 99);
		if( !$set ){
			echo "set faild\n";
			//	$error = $m->getResultCode();
			//	echo 'the error code is '.(string)$error."\n";
			$message = $m->getResultMessage();
			echo 'the error code is '.(string)$message."\n";
			exit;
		}
		echo "set successful\n";
		//$m->set('string', 'a simple string');
		//$m->set('array', array(11, 12));
		//$m->getDelayed(array('int', 'array'), true);
		$all = $m->fetchAll();
		print_r( $all );
	}
	public function db_connect()
	{
		$link = mysqli_connect( "127.0.0.1",'root','penny7531' );
//		$link = mysql_connect( "127.0.0.1:3306",'root','penny7531' );
// PHP 5.5.3报错 PHP Deprecated:  mysql_connect(): The mysql extension is deprecated and will be removed in the future: use mysqli or PDO instead
		if( !$link ){
			echo "the connect is refused\n";
			die();
		}
		else{
			//    echo "OK\n";
			$db_list = mysql_list_dbs( $link );
// PHP 5.5.3报错 PHP Deprecated:  Function mysql_list_dbs() is deprecated
// PHP 5.5.3报错 PHP Deprecated:  mysql_list_dbs(): This function is deprecated; use mysql_query() with SHOW DATABASES instead
			while( $db_row = mysql_fetch_object( $db_list ) ){
				//	    print_r( $db_row );
				$db = $db_row->Database;
				echo "db is $db \n";
				$table_list = mysql_list_tables( $db );
// PHP 5.5.3报错 PHP Deprecated:  Function mysql_list_tables() is deprecated
				//		print_r( $table_list );
				if( !$table_list ){
					print "DB Error,could not list tables\n";
					print "MySQL Error:".mysql_error();
					exit;
				}
				//		while( $table_row = mysql_fetch_row( $table_list ) ){
				//		    print_r( $table_row );
				//		    $talbe = $table_row[0];
				//			print "Table is $table\n";
				//		}
				for ( $i = 0;$i<mysql_num_rows( $table_list );$i++ ){
					$table = mysql_tablename( $table_list, $i );
					echo "table is $table \n";
					$field_list = mysql_list_fields( $db,$table,$link );
					for( $j=0;$j<mysql_num_fields( $field_list );$j++ ){
						try{
							$field = mysql_field_name( $field_list,$i );
						}
						catch ( Expection $e ){
						}
						echo "field is $field \n";
					}
				}
				//		mysql_free_result( $table_list );
			}
			$c_ch = mysql_client_encoding( $link );
			echo "the client encoding is $c_ch\n";	
			$c_info = mysql_get_client_info( );
			echo "The client info are $c_info\n";
			$s_info = mysql_get_server_info( $link );
			echo "The server info are $s_info\n";	
			$h_info = mysql_get_host_info( $link );
			echo "The host info are $h_info\n";
			$success = mysql_select_db( 'hotel_ts',$link );
			if( !$success ){
				echo "failed\n";
				exit;
			}
			$sql =  "select * from texts where id=300";
			//	$ret = mysql_query( $sql );
			$ret = mysql_query( $sql,$link )or die("Invalid query: " . mysql_error(  ) );
			if( !$ret ){
				echo "failed\n";
				exit;
			}
			//	$datas = mysql_fetch_array( $ret,MYSQL_BOTH );
			$datas = mysql_fetch_array( $ret,MYSQL_ASSOC );
			print_r( $datas );
		}
	}
	public function test_get_content()
	{
		$lines = file('http://www.baidu.com');
		print_r( $lines );
		$html = implode( '',file('http://www.baidu.com') );
		$html = implode( '周筱敏',file('http://www.baidu.com') );
		print_r( $html );
		$new_lines = file_get_contents('http://www.baidu.com');
		echo $new_lines."\n";

		$url = "http://www.baidu.com/百度百科";
		echo "url before dealing is $url\n";
		$url = urlencode( $url );
		echo "url after the firest dealing is $url \n";
		$url = urldecode( $url );
		echo "url after the second dealing is $url \n";

		$url = "http://www.baidu.com/";
		$head = get_headers( $url );
		print_r( $head );
	}
	private function bubble_sort( &$test,$length )
	{
		for( $i = $length -1;$i >= 0;$i-- ){
			for( $j = 0;$j<$i;$j++ ){
				if( $test[$j] > $test[$j+1] ){
					$temp = $test[$j];
					$test[$j] = $test[$j+1];
					$test[$j+1] = $temp;
				}
			}
		}
	}
	public function test_bubble_sort()
	{
		$test_array = array( 108,112,9,32,55,43,97,82,76,79 );
		print_r( $test_array );
		bubble_sort( $test_array,10 );
		print_r( $test_array );
	}
	//  数组
	public function test_array_point()
	{
		$transport = array('foot', 'bike', 'car', 'plane');
		$mode = current($transport); // $mode = 'foot';
		echo $mode."\n";
		$mode = next($transport);    // $mode = 'bike';
		echo $mode."\n";
		$mode = next($transport);    // $mode = 'car';
		echo $mode."\n";
		$mode = prev($transport);    // $mode = 'bike';
		echo $mode."\n";
		$mode = end($transport);     // $mode = 'plane';
		echo $mode."\n";
	}
	//  输出的区别
	public function diff_print()
	{
		$a = array (1, 2, array ("a", "b", "c"));
		var_dump( $a );
		var_export( $a );
		print_r( $a );
	}
    //  各种编码总结
    function multi_code()
    {
        $str = "anzhi market";
        echo "the encoding of str is ".mb_detect_encoding($str)." and it's value is $str and it's size is ".sizeof($str)."\n";
        //$str_trans = mb_convert_encoding($str,'EUC-KR','UTF-8');
        $str_trans = mb_convert_encoding($str,'UTF-8','ASCII');
        echo "the encoding of str_trans is ".mb_detect_encoding($str_trans)." and it's value is $str_trans and it's size is ".sizeof($str_trans)."\n";
        $str_zh = "安智市场";
        echo "the encoding of str_zh is ".mb_detect_encoding($str_zh)." and it's value is $str_zh and it's size is ".sizeof($str_zh)."\n";
        $str_zh_trans = mb_convert_encoding($str_zh,'EUC-KR','UTF-8');
        echo "the encoding of str_zh_trans is ".mb_detect_encoding($str_zh_trans)." and it's value is $str_zh_trans and it's size is ".sizeof($str_zh_trans)."\n";
    }
}
$tools = new Tools();
//$json = '';
//print_r( $tools->utf8( $json ) );
//print_r( $tools->get_time(  ) );

/*
$message = "Line 1\nLine 2\nLine 3";
$message = wordwrap($message, 70);
$success = mail( 'JimmyChou@ustc.edu','Hello world!',$message );
if( !$success ){
    echo "failed!\n";
	exit;
}
echo "successsful!\n";
*/
/*
$test = array();
print_r( $test );
//array_fill( 0,100,0 );
$test = array_fill( 0,100,0 );
print_r( $test );
*/

//$sql = 'UPDATE `data_type` SET `unsigned_tinyint`=`unsigned_tinyint`+1 WHERE `id`=1;';
//$sql = 'UPDATE `data_type` SET `unsigned_tinyint`=`unsigned_tinyint`-1 WHERE `id`=1;';

//$sql = 'UPDATE `data_type` SET `tinyint`=`tinyint`+1 WHERE `id`=1;';
//$sql = 'UPDATE `data_type` SET `tinyint`=`tinyint`-1 WHERE `id`=1;';
/*
$text = file_get_contents( '/home/jimmychou/下载/三国演义全集(UTF-8).txt' );

//  <<<EOT
//EOT


//$sql = "UPDATE `data_type` SET `text`=$text WHERE `id`=1;";   // 字符串型的尤其要注意，一定要用单引号括起来
$sql = "UPDATE `data_type` SET `mediumtext`='".$text."' WHERE `id`=1;";

$rs = mysql_query( $sql,$link );
if( !$rs ){
	echo 'query faild!'."\n".mysql_error( $link )."\nAnd it's mysql error number is ".mysql_errno( $link )."\n";
	exit;
}
$affected = mysql_affected_rows( $link );
echo 'affected row numbers is '.$affected."\n";

// 彻底解决跨浏览器下PHP下载文件名中的中文乱码问题
$prefix = '/home/jimmychou/下载/';
$ua = $_SERVER['HTTP_USER_AGENT'];
$filename = $prefix.'三国演义全集\(UTF-8\).txt';
$encoded_filename = urlencode( $filename );
$encoded_filename = str_replace( '+', ' ', $encoded_filename );
if( !file_exists( $encoded_filename ) ){
	echo 'the file '.$encoded_filename.' is not exist'."\n";
	exit();
}
exit;
header( 'Content-Type: application/octet-stream' );
if( preg_match( '/MSIE/', $ua ) ){
	    header( 'Content-Disposition: attachment; filename="' . $encoded_filename . '"' );
}
elseif(preg_match( '/Firefox/', $ua ) ){
	    header('Content-Disposition: attachment; filename*="utf8\'\'' . $filename . '"' );
}
else{
	    header( 'Content-Disposition: attachment; filename="' . $filename . '"' );
}
print 'ABC';


exit;


if (!isset( $_GET["file"]) || !isset( $_GET["type"])) {  
	print "no file selsect"; exit(); 
} 
$file = $_GET["file"].".".$_GET["type"]; 
if (@$fp = fopen($file,'r')){ 
	 header ("Content-type: octet/stream"); 
	  if (strstr( $_SERVER["HTTP_USER_AGENT"], "MSIE")){ 
		   header("Content-Disposition: filename=".mb_convert_encoding('宽带用户故障诊断处理手册.doc','GB2312','UTF-8')); // For IE 
		    }else{ 
				 header("Content-Disposition: attachment; filename=".mb_convert_encoding('宽带用户故障诊断处理手册.doc','GB2312','UTF-8')); // For Other browsers  
			} while(!@feof($fp)){ 
				 echo fread($fp,1024);  
			}
	  //@fpassthru($fp); 
	   exit();  
} else{ 
	 print "此文件不存在"; 
} 

//$file = "/ITC/jimmy/test";

//$file = "/ITC/jimmy/mario.mp3";

$file = "/ITC/jimmy/nice.png";

header("Content-type: application/octet-stream");

header('Content-Disposition: attachment; filename="' . basename($file) . '"');   // 起到改文件名的作用

$size = filesize( $file );

header("Content-Length: ". $size);

//echo "size is $size\n";
readfile($file);
*/

//悲催得很，直接复制的话引号会有很大的问题
/*
$a1 = null;
$a2 = false;
$a3 = 0;
//$a4 = ”;
$a4 = '';
//$a5 = ’0′;
$a5 = '0';
$a6 = 'null';
$a7 = array();
$a8 = array(array());
echo empty($a1) ? ‘true’ : ‘false’;
echo empty($a2) ? ‘true’ : ‘false’;
echo empty($a3) ? ‘true’ : ‘false’;
echo empty($a4) ? ‘true’ : ‘false’;
echo empty($a5) ? ‘true’ : ‘false’;
echo empty($a6) ? ‘true’ : ‘false’;
echo empty($a7) ? ‘true’ : ‘false’;
echo empty($a8) ? ‘true’ : ‘false’;
*/


/*
$test = 'aaaaaa';
$abc = &$test;
unset($test);
echo $test;
echo $abc;
*/


/*
$count = 5;
function get_count(){
static $count = 0;
return $count++;
}
echo $count;
++$count;
echo get_count();
echo get_count();
*/


/*
$GLOBALS['var1'] = 5;
$var2 = 1;
function get_value(){
global $var2;
$var1 = 0;
return $var2++;
}
get_value();
echo $var1;
echo $var2;
*/

/*
function get_arr($arr){
unset($arr[0]);
}
$arr1 = array(1, 2);
$arr2 = array(1, 2);
get_arr(&$arr1);
get_arr($arr2);
echo count($arr1);
echo count($arr2);
*/



/*
function listfile( $dir )
{
	if( !is_dir( $dir ) ){
		echo $file."\n";
		return false;
	}
	else{
		$fh = opendir( $dir );
		while( ( $file = readdir( $fh ) ) !== false ){
			if( is_dir( $file ) ){
				closedir( $fh );//too many file open...
				listfile( $dir.'/'.$file );
			}
			else{
				echo $file."\n";
			}
		}
	}
}
$dir = '/home/jimmychou';
$dir = '/';
listfile( $dir );
*/

//第一次访问为空，之后才是soso

/*
setcookie( "name","soso" );
var_dump( $_COOKIE["name"] );
*/

/*
try{
    require_once( "abc" );
    echo "abc";
}
catch ( exception $e ){
    echo "error occured\n";
}
*/
/*
var_dump( "8%2" );
var_dump( 8%2 );
var_dump( 40%(-21) );
*/
/*
$a = "abcdefg";
$b = &$a;
var_dump( $a );
var_dump( $b );
unset( $a );
var_dump( $a );
var_dump( $b );
*/
/*
setcookie( 'name','soso' );
echo $_COOKIE['name'];



require_once( 'abc' );
echo ('abc' )
try(){
   echo "exception";
}
*/
/*
$a="abcdefg";
$b=&$a;
unset($a);
echo $b;
echo "\n";
*/
//牵涉到数组在PHP中的存储结构
/*
$test = array( 1=>'nice',0=>'okbe',2=>'meto' );
$test2 = array( '1'=>'nice','0'=>'okbe','2'=>'meto' );
var_dump( $test );
print_r( $test );
foreach( $test as $key=>$value ){
    echo "key=$key and value=$value\n";
}
var_dump( $test2 );
print_r( $test2 );
foreach( $test2 as $key=>$value ){
    echo "key=$key and value=$value\n";
}
*/

//反转字符

//var_dump( $tools->renren_reverse( "I love this game holly shit!",2 ) );
//var_dump( $tools->renren_reverse( "这是什么",1 ) );
//var_dump( $tools->renren_reverse( "这是 什么 东西 为什么",2 ) );


// 强制类型转换

//var_dump( $tools->stick_convert( 222 ) );
//var_dump( $tools->stick_convert( '222' ) );
//var_dump( $tools->stick_convert( 'string' ) );

//var_dump( $tools->ref_count() );
//var_dump( $tools->xref_count() );

//var_dump( $tools->strange_int( ) );
//print_r( $tools->strange_int( ) );

//var_dump( array( 'status'=>'ok' ) );

// 用原生php-mysql库连接MySQL数据库
//var_dump( $tools->db_connect() );


//两个整型变量赋值，是不是一个存储空间？

//相对路径
             function relativePath($aPath, $bPath) {
                 $aArr = explode('/', $aPath);    //explode函数用于切分字符串,返回切分后的数组,此处用'/'切分字符串
                 $bArr = explode('/', $bPath);
                 $aDiffToB = array_diff_assoc($aArr, $bArr);    //array_diff_assoc()用于获取A数组与B数组之间元素的差集,Key和Value都不相同视为不同元素,此处返回在A数组中且与B数组不相同的元素
                 $count = count($aDiffToB);

                 $path = '';
                 for($i = 0; $i < $count - 1; $i++){
                     $path .= '../'; 
                 }

                 $path .= implode('/', $aDiffToB);    //implode()用于使用指定字符串连接数组元素,此处返回用'/'连接数组元素后的字符串

                 return $path;
             }

//             echo relativePath('/a/b/c/d/a.php', '/a/b/1/2/b.php')."\n";



//var_dump( intval( 0.58 * 100) );

/*
$str = '{"pagesCount":1,"topicList":[{"topicId":"59","isNew":false,"image":"http:\/\/imgsdown.1mobile.com\/group2\/M00\/B5\/59\/S36rZFOETbKAYI53AAFgkty2G2g084.jpg","name":"Flappy Bird Like","summary":"Click! Click! Click! Let your pets to fly farther!","releaseTime":"1969-12-31","view":0,"total":10,"type":"3"}]}{"pagesCount":1,"topicList":[{"topicId":"59","isNew":false,"image":"http:\/\/imgsdown.1mobile.com\/group2\/M00\/B5\/59\/S36rZFOETbKAYI53AAFgkty2G2g084.jpg","name":"Flappy Bird Like","summary":"Click! Click! Click! Let your pets to fly farther!","releaseTime":"1969-12-31","view":0,"total":10,"type":"3"}]}';
$arr = json_decode($str);
print_r( $arr );
*/

/*
$str = '"Im OK"';
//$link = mysql_connect( "127.0.0.1:3306","onemobile","need4speed_ok" );
$link = mysql_connect( "localhost","onemobile" );
if (!$link) {
    die('Could not connect: ' . mysql_error()."\n");
}
echo 'Connected successfully'."\n";
//mysql_close($link);
echo addslashes( $str )."\n";
echo mysql_real_escape_string( $str )."\n";
*/

function special_charactar($str)
{
    echo "json_encode the charactar $str is ".json_encode($str)."\n";
    echo "urlencode the charactar $str is ".urlencode($str)."\n";
    echo "json_encode(json_encode) the charactar $str is ".json_encode(json_encode($str))."\n";
}

special_charactar('&');

function same_key_in_array(array $sample)
{
    print_r($sample);
}
$sample = array('a'=>'nice','b'=>'ok','a'=>'niceagain');
same_key_in_array($sample);
//same_key_in_array("ok");

function restrict(int $int,array $array,string $string,object $object,null $null,float $float,bool $bool)//,resource $resource)
{
}

function float_add()
{
    //  @todo:bcmath
}
function image()
{
    header( "content-type:image/jpg" );
    $imageData = file_get_contents( '../image.jpg' );
    echo $imageData;
    //$info = gd_info();
    //echo '<pre>';print_r( $info );echo "\n";
    $img = imagecreatetruecolor( 200,200 );
    $white = imagecolorallocate( $img,255,255,255 );
    $black = imagecolorallocate( $img,0,0,0 );
    imagearc( $img,100,100,150,150,0,360,$black );
    imagepng( $img );
    imagedestroy( $img );
    $im = @imagecreatetruecolor(50, 100)
        or die("Cannot Initialize new GD image stream");
    $text_color = imagecolorallocate($im, 233, 14, 91);
    imagestring($im, 1, 5, 5,  "A Simple Text String", $text_color);
    imagepng($im);
    imagedestroy($im);
}
function tt()
{
    //$str = "\u6cd5\u5f8b\u95ee\u9898";
    $str = "中文";
    $utf8_str = utf8_encode($str);
    $invert_str = utf8_decode($utf8_str);
    echo "str = $str and utf8_str = $utf8_str and invert_str = $invert_str"."\n";

}

function whatyear()
{
    for($i=1970;$i<=2014;$i++){
        $time = strtotime("$i:01:01 00:00:00");
        $L = date('L',$time);
        $whatyear = ($L==1)? '闰年' : '平年';
        echo "the time is $time and the year $i is $whatyear\n";
    }
}

//whatyear();
//strtoupper对中文会如何？


function bar($x) {
    if ($x > 0) {
        bar($x - 1);
    }
}

function foo() {
    for ($idx = 0; $idx < 2; $idx++ ) {
        bar($idx);
        $x = strlen("abc");
    }
}

// start profiling
if(function_exists('xhprof_enable')){
    xhprof_enable();
}

// run program
foo();

// stop profiler
if(function_exists('xhprof_disable')){
    $xhprof_data = xhprof_disable();
    print_r($xhprof_data);
}

// display raw xhprof data for the profiler run

//  stream

//echo file_get_contents('php://')."\n";
//echo file_get_contents('file://')."\n";


//

//echo "\a\b\t\n";
//$max=128

/*;
$max=1024;
for($i=0;$i<$max;$i++){
        echo chr($i)."\n";
}
*/


//  exit能否打印
//exit('haha');


//  static

$a = "nice to meet you\n";
function printt($a)
{
        //global $a;
            static $a;
                echo $a."\n";
}
printt("how do you do\n");



//  error
$result = array();
for($i=0;$i<3;$i++){
    $tmp = array($i+1,$i+2);
    $tmp[] = '恒定';
    $result[] = $tmp;
}
print_r($result);


#   last_group_name变量覆盖问题
$infos = array();
if(!empty($infos)){
    foreach($infos as $k=>$info){
        $group_index = $wanted[$softid][0];
        $group_name = $type2groupname[$type][$group_index];
        $last_group_index = $group_index;
        $last_group_name = $group_name;
    }
}
$str = '{"data":"XawrFkW3uLpRNm9\/hUw+oPGNA1+GgDedtLp4\/k\/zfrWoBZDjSQPuFPR0qALRW5l4QnQnLewR82gJsYfs3dK9LEARPsFb7fMW","serviceId":"007","serviceVersion":"V5.3","serviceType":"0","device":"{\"deviceid\":\"528748979873541\",\"osver\":18,\"nettype\":\"UNIWAP\",\"netserver\":0,\"screen\":\"1080*1920\",\"imsi\":4.600158806566e+14,\"mac\":\"0c:37:dc:68:07:8b\",\"ip\":\"127.0.0.1\",\"abi\":null}"}';
print_r(json_decode(json_decode($str,true)['device'],true));

function system_function()
{
    echo php_uname().PHP_EOL;
    echo PHP_OS.PHP_EOL;
}

function protocal()
{
    /*
    // Set the limit to 5 MB.
    $fiveMBs = 5 * 1024 * 1024;
    $fp = fopen("php://temp/maxmemory:$fiveMBs", 'r+');

    fputs($fp, "hello\n");

    // Read what we have written.
    rewind($fp);
    echo stream_get_contents($fp);
     */

    $url = 'http://www.baidu.com/index.php';
    $fp = fopen($url,'r');
    $meta_data = stream_get_meta_data($fp);
    foreach ($meta_data['wrapper_data'] as $response){
        /* 我们是否被重定向了？ */
        if (strtolower(substr($response, 0, 10)) == 'location: '){
            /* 更新我们被重定向后的 $url */
            $url = substr($response, 10);
        }
    }
    echo "url=$url\n";
}

function time_function()
{
    print_r(gettimeofday());
    echo 'the time is '.gettimeofday(true)."\n";
    echo "日出时间是".date_sunrise(time(), SUNFUNCS_RET_STRING, 38.4, -9, 90, 1)."\n";
    echo "日落时间是".date_sunset(time(), SUNFUNCS_RET_STRING, 38.4, -9, 90, 1)."\n";
}

function preg_function()
{
    $str = '<a href="forum.php?mod=forumdisplay&fid=386"><img src="http://attach.anzhi.com/common/39/common_386_icon.png" align="left" alt="" /></a>';
    $tmp1 = explode('src=',$str);
    print_r($tmp1);
    $tmp2 = explode('"',$tmp1[1]);
    $ret = $tmp2[1];
    echo "the ret is $ret\n";
}

function float_function()
{
    $a = 1.23456789;
    $b = 1.23456780;
    $epsilon = 0.00001;

    if(abs($a-$b) < $epsilon) {
        echo "true\n";
    }
    echo gettype(19.6*100)."\n";
    if((19.6*100)===(double)1960){
        echo "equal\n";
    }
    else{
        echo "not equal\n";
    }
}

function bcExp($xArg, $NumDecimals)
{
    $x = Trim($xArg);
    $PrevSum  = $x - 1;
    $CurrTerm = 1;
    $CurrSum  = bcAdd("1", $x, $NumDecimals);
    $n        = 1;
    echo "x=$x NumDecimals=$NumDecimals CurrTerm=$CurrTerm CurrSum=$CurrSum \n";
    While (bcComp($CurrSum, $PrevSum, $NumDecimals))
    {
        $PrevSum  = $CurrSum;
        $CurrTerm = bcDiv(bcMul($CurrTerm, $x, $NumDecimals), $n + 1, $NumDecimals);
        $CurrSum  = bcAdd($CurrSum, $CurrTerm, $NumDecimals);

        $n++;
    }
}
echo $y = bcExp("1.7", 36);
echo $y;


function filter_function()
{
    $email_a = 'joe@example.com';
    $email_b = 'bogus';

    if (filter_var($email_a, FILTER_VALIDATE_EMAIL)) {
        echo "This ($email_a) email address is considered valid.";
    }
    if (filter_var($email_b, FILTER_VALIDATE_EMAIL)) {
        echo "This ($email_b) email address is considered valid.";
    }
}


function ob_function()
{
    //your_benchmark_start_function();
    ob_start ();
    for ($i = 0; $i < 5000; $i++)
        echo str_repeat ("your string blablabla bla bla", (rand() % 4) + 1)."<br>\n";
    //echo your_benchmark_end_function(); 
    ob_end_flush (); 
}

function mbstring_function()
{
    $string  = '漢字はユニコード';
    $needle  = 'は';
    $replace = 'Foo';

    echo str_replace($needle, $replace, $string);
    // outputs: 漢字Fooユニコード
}


function counter_function()
{
    function print_counter_info($counter)
    {
        if (is_resource($counter)) {
            printf("计数器的名称为 '%s'，且%s进行持久化。其当前值为 %d.\n",
                    counter_get_meta($counter, COUNTER_META_NAME),
                    counter_get_meta($counter, COUNTER_META_IS_PERSISTENT) ? '' : '不',
                    counter_get_value($counter));
        } else {
            print "计数器无效!\n";
        }
    }

    if (($counter_one = counter_get_named("one")) === NULL) {
        $counter_one = counter_create("one", 0, COUNTER_FLAG_PERSIST);
    }
    counter_bump_value($counter_one, 2);
    $counter_two = counter_create("two", 5);
    $counter_three = counter_get_named("three");
    $counter_four = counter_create("four", 2, COUNTER_FLAG_PERSIST | COUNTER_FLAG_SAVE | COUNTER_FLAG_NO_OVERWRITE);
    counter_bump_value($counter_four, 1);

    print_counter_info($counter_one);
    print_counter_info($counter_two);
    print_counter_info($counter_three);
    print_counter_info($counter_four);
}

function core_dump_function()
{
    function recurse($num){
        recurse(++$num);
    }
    recurse(0);

}

function buffer_function()
{
    ob_start(); 
    echo "1:blah\n"; 
    ob_start(); 
    echo "2:blah"; 
    // ob_get_clean() returns the contents of the last buffer opened.  The first "blah" and the output of var_dump are flushed from the top buffer on exit 
    var_dump(ob_get_clean()); 
    exit; 
}

function tttt()
{
    //array_merge和+对数组中元素排序的影响

    $present_list = array(11=>'p1',12=>'p2',13=>'p3');
    //$past_list = array(21=>'a1',22=>'a2',23=>'a3');
    $past_list = array(21=>'p1',22=>'p2',23=>'p3');
    $first_release_list = array_merge($present_list,$past_list);
    print_r($first_release_list);
    $first_release_list = $present_list + $past_list;
    print_r($first_release_list);
    exit;
    $new_data = array();
    $data = array(
            0=>array(00,01,02,03)
            ,1=>array(10,11,12,13)
            ,2=>array(20,21,22,23)
            ,3=>array(30,31,32,33)
            );
    //$new_data = array_splice($data,1,4);
    //$new_data = array_fill(
    print_r($new_data);
    exit;
    print_r(array_slice($data,0,10));

    exit;
    $vr = 6;
    $flg_map = array(
            'uninstalled_download' => array(
                1 => 1,
                2 => 2,
                ),
            'installed_select' => array(
                1 => 8,
                2 => 16,
                3 => 32,
                4 => 64,
                ),
            'uninstalled_silent' => array(
                1 => 4
                ),
            'lower_version_select' => array(
                1 => 128,
                2 => 256,
                3 => 512,
                ),
            'lower_version_silent' => array(
                1 => 1024
                ),
            );
    $opt_flg = 0;
    //print_r($flg_map);
    if($vr>=5){
        $addtion_map = array(
                'installed_select'=>array(5=>2048),
                'lower_version_select'=>array(4=>4096),
                );
        $flg_map =  array_merge_recursive($flg_map,$addtion_map);

        //    $flg_map = array_merge($flg_map,$addtion_map);

        /*
           foreach($addtion_map as $col=>$val){
           $flg_map_col = $flg_map[$col];
           $flg_map_col = array_merge($flg_map_col,$val);
           $flg_map[$col] = $flg_map_col;  //  如此数字索引也不正确

        //以下看似相同，其实不然
        //$flg_map[$col] = array($flg_map[$col],$val);
        }
         */


        //    $flg_map['installed_select'][5] = 2048;
        //    $flg_map['lower_version_select'][4] = 4096;
    }
    //print_r($flg_map);


    $replace_map = array(
            8=>array(
                'installed_select'=>array(5=>3),
                'lower_version_select'=>array(4=>2),
                ),
            5=>array(
                'installed_select'=>array(5=>3),
                'lower_version_select'=>array(4=>2),
                ),
            7=>array(
                'installed_select'=>array(5=>3),
                'lower_version_select'=>array(4=>2),
                ),
            1=>array(
                'installed_select'=>array(5=>3),
                'lower_version_select'=>array(4=>2),
                ),
            6=>array(
                'installed_select'=>array(5=>3),
                'lower_version_select'=>array(4=>2),
                ),
            );
    foreach($replace_map as $index=>$value){
        echo "the index is $index\n";
    }
    ksort($replace_map);
    echo "--------------------------------------------------------------------------------\n";
    foreach($replace_map as $index=>$value){
        echo "the index is $index\n";
    }
    krsort($replace_map);
    echo "--------------------------------------------------------------------------------\n";
    foreach($replace_map as $index=>$value){
        echo "the index is $index\n";
    }

}

function inverse($x) {
    if (!$x) {
        throw new Exception('Division by zero.');
    }
    else return 1/$x;
}

try {
    echo inverse(5) . "\n";
    echo inverse(0) . "\n";
} 
catch (Exception $e) {
    echo 'Caught exception: ',  $e->getMessage(), "\n";
}

// Continue execution
echo 'Hello World';


foreach($forumlist as $index=>$single){
//    $result[]['TITLE'] = iconv('ISO-8859-1','UTF-8',$single['name']);
//    $result[]['TYPE'] = $single['type'];
//    $result[]['ID'] = $single['fid'];
    $result[$index]['TITLE'] = iconv('ISO-8859-1','UTF-8',$single['name']);
    $result[$index]['TYPE'] = $single['type'];
    $result[$index]['ID'] = $single['fid'];
}


//  数组加法和merge的区别
$a = array(
    '323'=>'a',
        '123'=>'a',
        );
$b = array(
    '223'=>'b',
        '323'=>'b',
        );
var_dump($a);
var_dump($b);
$c = $a+$b;
$d = array_merge($a,$b);
print_r($c);
print_r($d);

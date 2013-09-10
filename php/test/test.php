<?php
class Tools
{
	function mb_str_split( $string, $split_length = 1 ){
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
	function renren_reverse( $str,$mode=1 )
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
	}
	function __autoload( $classname )
	{
		//    require_once ( $classname.'.class.php' );
	}
	//$person = new Person( 'Altair', 6 );
	//var_dump ( $person );

	function stick_convert()
	{
		// 强制类型转换
		$str = '222';
		$int = intval( $str );
		echo '$str='.$str.' and type is '.gettype( $str ).' and int='.$int.' and type is '.gettype( $int )."\n";
	}

	function ref_count()
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

	function strange_int()
	{
		echo (int) ( (0.1+0.7) * 10 )."\n";
	}
	// array_intersect,array_intersect_assoc,array_diff,array_diff_assoc等四个区别取值函数，array_intersect和array_diff相同，保留键名时，与第一个数组里的键值相等。
	// array_slice,array_splice等两个拆分函数注意 array_slice的第四个参数
	// array_combine,array_merge,array_merge_recursive等三个合并函数以及+的区别
	// array_fill

	//print_r( htmlspecialchars( 'http://www.baidu.com' ) );
	function merge_error()
	{
		$temp = array();
		//$temp = null;
		$temp = array_merge( $temp,array( 'user_id'=>1 ) );
		print_r( $temp );
	}

	// for phpredis library
	function phpredis_lib()
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
	function check_empty( $data )
	{
		if( empty( $data ) ){
			echo "it's empty\n";
		}
		else{
			echo "it's not empty\n";
		}
	}
	function check_value( $data )
	{
		if( !$data ){
			echo "it has no data\n";
		}
		else{
			echo "it has data\n";
		}
	}
	function test_value()
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
	function andor()
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
	function inverse($x)
	{
		if (!$x) {
			throw new Exception('Division by zero.');
		}
		else return 1/$x;
	}
	function test_inverse()
	{
		try{
			echo inverse( 5 ) . "\n";
			echo inverse( 0 ) . "\n";
		} 
		catch( Exception $e ){
			echo 'Caught exception: ',  $e->getMessage(), "\n";
		}
	}
	function diff_array_merge()
	{
		$arr1 = array('a', 'b', 'c', 'd', 'e');
		$arr2 = array('a', 'b', 'c', 'd', 'e','f','g');
		print_r( array_merge( $arr1,$arr2 ) );
		print_r( array_merge( $arr2,$arr1 ) );
		$arr3 = $arr1 + $arr2;
		print_r( $arr3 );
	}
	function get_time()
	{
		$timezone = date_default_timezone_get();
		echo "你的电脑使用时区为$timezone\n";
		$now = time();
		$now = date("Y-m-d H:i:s D l j N S w z W F a B e I O P T Z c r U",$now);
		echo "现在时刻$now\n";
	}
	function utf8()
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
		$link = mysql_connect( "127.0.0.1:3306",'root','' );
		if( !$link ){
			echo "the connect is refused\n";
			die();
		}
		else{
			//    echo "OK\n";
			$db_list = mysql_list_dbs( $link );
			while( $db_row = mysql_fetch_object( $db_list ) ){
				//	    print_r( $db_row );
				$db = $db_row->Database;
				echo "db is $db \n";
				$table_list = mysql_list_tables( $db );
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
}
$tools = new Tools();
$json = '';
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
//var_dump( $tools->renren_reverse( "I love this game holly shit!",2 ) );
//var_dump( $tools->renren_reverse( "这是什么",1 ) );
var_dump( $tools->renren_reverse( "这是 什么 东西 为什么",2 ) );

//两个整型变量赋值，是一个存储空间么？

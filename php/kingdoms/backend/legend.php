<?php
class Legend
{
	static public function three_kingdoms()
	{
	    $loc = dirname(__FILE__);
	    echo "the current directory is $loc \n";
		$con = mysql_connect("localhost","root");
		if( $con ){
			echo "OK!Connect to mysql server successful and the connect identify is\n";
			print_r( $con."\n" );
			$db_list = mysql_list_dbs( $con );
			while ($db = mysql_fetch_object($db_list)){
				echo $db->Database . "\n";
			}
			mysql_select_db("three_kingdoms");
			$code = mysql_client_encoding( $con );
			echo "The old encoding is $code";
            $suc = mysql_set_charset( "gbk",$con );
			if( $suc == true ){
				echo "\nSet new encoding successful\n";
			}
			$new_code = mysql_client_encoding( $con );
			echo "The new encoding is $new_code\n";

			$sql = "SELECT * FROM generals";
			$result = mysql_query( $sql );
			while ( $row = mysql_fetch_object( $result ) ){
			//	while ( $row = mysql_fetch_array( $result ) ){
				$generals[] = $row;
			}
			mysql_close($con);
		}
		ob_start();
		echo "<?php\n";
		echo " class Generals \n { \n";
		echo "    static ".'$_generals'."=array(";
		foreach( $generals as $order =>$general ){
		    $index = $order+1;
			echo "$index=>array(";
			foreach( $general as $k=>$v ){
				echo "'"."$k'"."=>'"."$v'".",";
			}
			echo "),\n";
		}
		echo ");\n";
		echo "    static function getGeneralByNumber (".' $num '.")\n    {\n";
		echo "        return ".'self::$_generals[ $num ];'."\n    }\n";
		echo "    static function getGeneralByName (".' $name '.")\n    {\n";
		echo '        foreach ( self::$_generals as $general ){'."\n";
		echo '            if( $general["姓名"] != $name )';
		echo "\n                continue;\n";
		echo "            else\n";
		echo "                return ".'$general;';
		echo "\n        }";
		echo "\n    }\n";
		echo "}";
		$content=ob_get_contents();
		ob_end_clean();
		file_put_contents( $loc."/generals.php",$content,NULL,NULL);
	}
}

Legend::three_kingdoms();
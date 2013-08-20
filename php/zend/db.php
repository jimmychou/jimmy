<?php
require_once 'Zend/Db.php';
$params = array ('host'     => '127.0.0.1',
                 'username' => 'root',
                 'password' => '',
                 'dbname'   => 'hotel_data_1'
				);
$db = Zend_Db::factory('PDO_MYSQL', $params);
if( !$db ){
    echo "failed!\n";
	exit;
}
/*
echo "successful!\n";
$sql = $db->quoteInto( 'select * from user_accounts where id< ?','3' );
echo "the sql is $sql\n";
$result = $db->query( $sql );
print_r( $result );
$rows = $result->fetchAll();
print_r( $rows );


$sql = 'St John"s Wort';
echo "old sql is $sql\n";
$sql = $db->quote( $sql );
echo "new sql is $sql\n";



$sql = array('a', 'b', 'c');
//echo "old sql is ".print_r( $sql )."\n";
echo "old sql is \n";
print_r( $sql );
echo "\n";
$sql = $db->quote( $sql );
echo "new sql is $sql\n";
*/


// insert
/*
$row = array('deal_flag'=>'nice'
             ,'user_id'=>1
			 ,'money'=>100
			 ,'gem'=>10
			 ,'deal_name'=>'JimmyChou'
			 ,'content'=>'just a test'
			 ,'room_id'=>111
            );
$table = 'consumptions';
$row_affected = $db->insert( $table,$row );
echo 'the affected row as follow:'."\n";
print_r( $row_affected );
echo "\n";
$last_insert_id = $db->lastInsertId();
echo "the last insert id is $last_insert_id\n";
*/


// update
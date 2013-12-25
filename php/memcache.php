<?php

$cache = new Memcache;
$con = $cache->connect('localhost',11211);
if( $con ){
	echo "successful!\n";
	print_r( $con );
	$cache->addServer('10.13.81.112',11211);
	$cache->addServer('10.13.81.111',11211);
	$cache->addServer('10.13.81.122',11211);
	$cache->addServer('10.13.81.123',11211);
	$cache->addServer('10.13.81.127',11211);
	$cache->addServer('10.13.81.128',11211);
	print_r( $cache );
	print_r( $cache->getStats() );
	print_r( $cache->getExtendedStats() );
}
else{
	echo "failed!\n";
}
?>

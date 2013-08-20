<?php
/*
define some constants such as inc path
*/

define('WORK_ROOT','/home/hotel/work/');
define('WEB_ROOT', dirname(__FILE__).'/');
define('APP_ROOT',realpath(WEB_ROOT.'/..').'/');
define('PUBA_ROOT',APP_ROOT.'webreject/');
define('LIB_ROOT',PUBA_ROOT.'lib/');

/*
define('WORK_ROOT','/home/hotel/work/');
define('WEB_ROOT', dirname(__FILE__).'/');

define('APP_ROOT',realpath(WEB_ROOT.'/..').'/');

define('PUBA_ROOT',APP_ROOT.'webreject/');


define('AMF_SERVER_ROOT',PUBA_ROOT.'server/');
define('LIB_ROOT',PUBA_ROOT.'lib/');
define('MODEL_ROOT',PUBA_ROOT.'model/');
define('CONTROLLER_ROOT',PUBA_ROOT.'controller/');

define('LOG_ROOT',PUBA_ROOT.'log/'); //for write

define('PLATFORM_ROOT',PUBA_ROOT.'platform/');






define('USERNUM_PERDB','1000000');#one database user num
define('TM_FORMAT','Y-m-d H:i:s');

//here two directory must be writable by user who run php
define('REQ_DATA_ROOT',WEB_ROOT.'tests/request/');
define('RES_DATA_ROOT',WEB_ROOT.'tests/request/');




#other config
require_once WEB_ROOT.'config.php'; #platform specified config
require_once WEB_ROOT.'server_config.php';


error_reporting(E_ALL & ~E_NOTICE);

//for
define('ZEND_ROOT_MY',APP_ROOT.'../../');
define('ZEND_ROOT',WORK_ROOT.'sys/Zend/ZendFramework-1.9.4-minimal/library/');
set_include_path(ZEND_ROOT. PATH_SEPARATOR . ZEND_ROOT_MY.PATH_SEPARATOR.get_include_path());



date_default_timezone_set('Asia/Chongqing');   
#for zend
require_once 'Zend/Loader/Autoloader.php';
require_once WEB_ROOT.'MyLoader.php';
$autoloader = Zend_Loader_Autoloader::getInstance();
//$autdoloader ->
//$autoloader->unshiftAutoloader(new MyLoader());

//* 
require_once LIB_ROOT.'Logger.php';
# tools from lib
require_once LIB_ROOT.'CrabTools.php';
require_once LIB_ROOT.'AutoIncIdGenerator.php';
require_once LIB_ROOT.'MemcacheClient.php';
require_once LIB_ROOT.'DbText.php'; 
//*/
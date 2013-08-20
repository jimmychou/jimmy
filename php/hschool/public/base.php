<?php

require_once 'config.php';

define('PUB_ROOT',__DIR__.'/');
//require_once __DIR__."/config.php";  // <<-- 初始化 page root  & pub root
if(IS_PRODUCTION){
    error_reporting(E_ALL ^ E_NOTICE);
    ini_set('display_errors','off');
}

define('TM_FORMAT','Y-m-d H:i:s');

if(CURRENT_PLATFORM!='pengyou'){
    define('WORK_ROOT','/home/hotel/');
    define('LOG_ROOT',WORK_ROOT.'work/log/'); //for write
}else{
    define('WORK_ROOT','/data/work/');
    define('LOG_ROOT',WORK_ROOT.'log/'); //for write
}
define('COMMON_ROOT',WORK_ROOT .'backend_common/');
define('LIB_ROOT',COMMON_ROOT.'phplib/');

define('WEB_ROOT', PUB_ROOT);//for compatible
define('PUBA_ROOT', PUB_ROOT.'webreject/');
define('CONTROLLER_ROOT',PUBA_ROOT.'controller/');
define('MODEL_ROOT',PUB_ROOT.'ttserver/');
define('CONFIG_HANDLER',PUB_ROOT.'config_handler/');

define('NUMERIC_CONF', PAGE_ROOT.'gamelogic/numeric/');
define('REQ_DATA_ROOT',PAGE_ROOT.'tests/request/');
define('RES_DATA_ROOT',PAGE_ROOT.'tests/request/');


//require_once MODEL_ROOT.'TTG.php';
//require_once PUB_ROOT.'PFCommon.php';
//require_once PAGE_ROOT.'platform_tools.php';

/*
 * 自動加載配置文件的類
 * 配置文件放在NUMERIC_CONF目錄下面，文件名類似於 g_employee_config
 * 配置文件中配置項爲一個數組，數組名與文件名相同
 */
class GameConfig{
    static $_config=array();
    public static function get_config($config_name){
        if(isset(self::$_config[$config_name])){
            return self::$_config[$config_name];
        }else{
            if(file_exists(NUMERIC_CONF."/{$config_name}.php")){
                include NUMERIC_CONF."/{$config_name}.php";
            }else if(file_exists(CONFIG_HANDLER."/{$config_name}.php")){
                include CONFIG_HANDLER."/{$config_name}.php";
            }else{
                error_log("failed to load config $config_name");
                throw new Exception ("failed to load config $config_name");
            }
            if(isset($$config_name)){
                self::$_config[$config_name]=$$config_name;
                return self::$_config[$config_name];
            }else{
                error_log("failed to load config $config_name");
                throw new Exception ("failed to load config $config_name");
            }
        }
    }
}
/*
 * 自动加载class
 * 为了避免性能问题,目前只用于加载CONFIG_HANDLER 目录下的文件
 */
function config_handler_autoload($class_name){
    @include_once(CONFIG_HANDLER."/{$class_name}.php");
    //return class_exists($class_name,false) || interface_exists($class_name,false);
}
spl_autoload_register('config_handler_autoload');
